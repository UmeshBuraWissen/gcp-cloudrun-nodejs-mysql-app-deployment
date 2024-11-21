const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2');
const path = require('path');
const bcrypt = require('bcryptjs');
const session = require('express-session');
const { SecretManagerServiceClient } = require('@google-cloud/secret-manager');

const app = express();
const port = process.env.PORT || 4000;  // Use the PORT environment variable for Cloud Run or local development
const project_id = process.env.projectid;
const db_connection_name = process.env.dbconnectionname;

// Initialize Secret Manager Client
const client = new SecretManagerServiceClient();

// Function to get secrets from Google Secret Manager
async function getSecret(secretName) {
    const [version] = await client.accessSecretVersion({
        name: `projects/${project_id}/secrets/${secretName}/versions/latest`,
    });
    return version.payload.data.toString('utf8');
}

// Database connection
/* async function connectToDatabase() {
    const user = await getSecret('DB_USERNAME');
    const password = await getSecret('DB_PASSWORD');
    
    const db = mysql.createConnection({
        host: `${db_connection_name}`, // Use Cloud SQL connection name
        user: user,
        password: password, // Ensure this database exists
    });

    db.connect(err => {
        if (err) {
            console.error('Database connection failed:', err);
            return;
        }
        console.log('Connected to database');

    });

    return db;
} */

    async function connectToDatabase() {
        const user = await getSecret('DB_USERNAME');
        const password = await getSecret('DB_PASSWORD');
        
        //const db_connection_name = 'your-cloud-sql-connection-name'; // Replace with your Cloud SQL connection name
    
        // Step 1: Connect to MySQL
        const db = mysql.createConnection({
            host: `${db_connection_name}`,
            //host: `${db_connection_name}`, // Use Cloud SQL connection name
            user: user,
            password: password,
        });
    
        // Connect to MySQL
        db.connect(async (err) => {
            if (err) {
                console.error('Database connection failed:', err);
                return;
            }
            console.log('Connected to database');
    
            // Step 2: Check if the database exists, and create it if it does not
            db.query('CREATE DATABASE IF NOT EXISTS registration_db', (err, results) => {
                if (err) {
                    console.error('Error creating database:', err);
                    return;
                }
                console.log('Database "registration_db" is ready or has been created');
                
                // Step 3: Use the newly created or existing database
                db.changeUser({ database: 'registration_db' }, (err) => {
                    if (err) {
                        console.error('Error switching to "registration_db":', err);
                        return;
                    }
                    console.log('Switched to "registration_db"');
    
                    // Step 4: Create the 'users' table if it doesn't exist
                    const createUsersTableQuery = `
                        CREATE TABLE IF NOT EXISTS users (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            username VARCHAR(50) NOT NULL,
                            email VARCHAR(100) NOT NULL UNIQUE,
                            password VARCHAR(255) NOT NULL,
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                        );
                    `;
                    
                    db.query(createUsersTableQuery, (err, results) => {
                        if (err) {
                            console.error('Error creating users table:', err);
                            return;
                        }
                        console.log('Table "users" is ready or has been created');
                        
                        // Step 5: Create the 'userdetails' table if it doesn't exist
                        const createUserDetailsTableQuery = `
                            CREATE TABLE IF NOT EXISTS userdetails (
                                detail_id INT AUTO_INCREMENT PRIMARY KEY,
                                userid INT NOT NULL,
                                username VARCHAR(255) NOT NULL,
                                phone_number VARCHAR(15),
                                email_address VARCHAR(255),
                                address TEXT,
                                FOREIGN KEY (userid) REFERENCES users(id)
                            );
                        `;
                        
                        db.query(createUserDetailsTableQuery, (err, results) => {
                            if (err) {
                                console.error('Error creating userdetails table:', err);
                                return;
                            }
                            console.log('Table "userdetails" is ready or has been created');
                        });
                    });
                });
            });
        });
    
        return db;
}

// Connect to the database
let db;
connectToDatabase().then(connection => {
    db = connection;
}).catch(err => {
    console.error('Failed to connect to the database:', err);
});

// Middleware Configuration
app.use(bodyParser.urlencoded({ extended: true }));

app.use(session({
    secret: process.env.SESSION_SECRET || 'your-secret-key',  // Consider storing this securely in env variables
    resave: false,
    saveUninitialized: true,
}));

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.use('/images', express.static(path.join(__dirname, 'images')));

// Middleware to check if user is logged in
function isAuthenticated(req, res, next) {
    if (req.session.userId) {
        return next();
    } else {
        return res.redirect('/login');
    }
}

// Routes

// Home Route
app.get('/', (req, res) => {
    res.render('index');
});

// Registration Route
app.post('/register', async (req, res) => {
    const { username, email, password, phone, address } = req.body;

    try {
        // Hash the password
        const hashedPassword = await bcrypt.hash(password, 10);

        // Insert user into registration_db
        const sql = 'INSERT INTO users (username, email, password) VALUES (?, ?, ?)';
        db.query(sql, [username, email, hashedPassword], (err, result) => {
            if (err) {
                console.error('Error during registration:', err);
                return res.status(500).send('Error during registration');
            }

            // Insert user details into userdetails table
            const userId = result.insertId;  // Get the user ID from the 'users' table
            const userDetailsSql = `
                INSERT INTO userdetails (userid, username, phone_number, email_address, address)
                VALUES (?, ?, ?, ?, ?)
            `;
            db.query(userDetailsSql, [userId, username, phone, email, address], (err, result) => {
                if (err) {
                    console.error('Error inserting user details:', err);
                    return res.status(500).send('Error inserting user details');
                }

                // After successful registration, log the user in
                req.session.userId = userId;  // Storing the new user's ID
                req.session.username = username;  // Storing username
                res.redirect('/dashboard');
            });
        });
    } catch (err) {
        console.error('Error in registration process:', err);
        res.status(500).send('Internal Server Error');
    }
});

// Login Route
app.post('/login', (req, res) => {
    const { username, password } = req.body;
    const sql = 'SELECT * FROM users WHERE username = ?';

    db.query(sql, [username], async (err, results) => {
        if (err) {
            console.error('Database error during login:', err);
            return res.status(500).send('Error during login');
        }

        if (results.length === 0) {
            return res.status(401).send('Invalid username or password');
        }

        try {
            const isMatch = await bcrypt.compare(password, results[0].password);
            if (!isMatch) {
                return res.status(401).send('Invalid username or password');
            }

            // Set session variables
            req.session.userId = results[0].id;
            req.session.username = results[0].username;

            // Redirect to the dashboard
            res.redirect('/dashboard');
        } catch (err) {
            console.error('Error comparing passwords:', err);
            res.status(500).send('Error during login');
        }
    });
});

// Dashboard Route (Protected)
app.get('/dashboard', isAuthenticated, (req, res) => {
    res.setHeader('Cache-Control', 'no-store, no-cache, must-revalidate, proxy-revalidate');

    const { username, userId } = req.session;

    // Query user details from the userdetails table
    const userDetailsQuery = `
        SELECT userid, username, phone_number, email_address, address 
        FROM userdetails 
        WHERE username = ? AND userid = ?;
    `;

    db.query(userDetailsQuery, [username, userId], (err, results) => {
        if (err) {
            console.error('Error fetching user details:', err);
            return res.status(500).send('Error loading user details');
        }

        if (results.length === 0) {
            return res.status(404).send('No user details found for the current user');
        }

        // Pass user details as an object (results[0])
        res.render('dashboard', { 
            username, 
            userDetails: results 
        });
    });
});

// Logout Route
app.get('/logout', (req, res) => {
    req.session.destroy((err) => {
        if (err) {
            return res.status(500).send('Error during logout');
        }
        res.redirect('/');
    });
});

// Start the server
app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});
