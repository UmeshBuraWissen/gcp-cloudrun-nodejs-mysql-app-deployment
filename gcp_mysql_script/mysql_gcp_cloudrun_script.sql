-- Create the database
CREATE DATABASE registration_db;
 
-- Select the database to use
USE registration_db;
 
-- Create the user table 
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Create the userdetails table
CREATE TABLE userdetails (
    detail_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each detail row
    userid INT NOT NULL,                     -- User ID (can have duplicates)
    username VARCHAR(255) NOT NULL,          -- Username
    phone_number VARCHAR(15),                -- Phone number
    email_address VARCHAR(255),              -- Email address
    address TEXT,                            -- Address
    FOREIGN KEY (userid) REFERENCES users(id) -- Foreign key linking to users table
);

INSERT INTO users (id, username, email, password, created_at)
VALUES (1, 'wissen1', 'wissen1@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(2, 'wissen2', 'wissen2@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(3, 'wissen3', 'wissen3@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(4, 'wissen4', 'wissen4@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(5, 'wissen5', 'wissen5@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(6, 'wissen6', 'wissen6@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(7, 'wissen7', 'wissen7@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(8, 'wissen8', 'wissen8@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(9, 'wissen9', 'wissen9@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(10, 'wissen10', 'wissen10@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(11, 'wissen11', 'wissen11@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(12, 'wissen12', 'wissen12@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(13, 'wissen13', 'wissen13@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(14, 'wissen14', 'wissen14@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(15, 'wissen15', 'wissen15@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(16, 'wissen16', 'wissen16@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(17, 'wissen17', 'wissen17@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(18, 'wissen18', 'wissen18@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(19, 'wissen19', 'wissen19@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36'),
(20, 'wissen20', 'wissen20@wissen.com', '$2a$10$1c7x2NvWc8vHTzWya1vD6uZS.uPKL7oC/CX5NAwkOk2tVNpkqkYLS',	'2024-11-18 13:28:36');
	


INSERT INTO userdetails (userid, username, phone_number, email_address, address)
VALUES (1, 'wissen1', '+91 8793115474', 'wissen1@wissen.com', 'Bangalore, Karanatka'),
    (2, 'wissen2', '+91 8605198763', 'wissen2@wissen.com', 'Bangalore, Karanatka'),
     (3, 'wissen3', '+91 9284597479', 'wissen3@wissen.com', 'Bangalore, Karanatka'),
     (4, 'wissen4', '+91 9823352551', 'wissen4@wissen.com', 'Bangalore, Karanatka'),
     (5, 'wissen5', '+91 9326979748', 'wissen5@wissen.com', 'Bangalore, Karanatka'),
     (6, 'wissen6', '+91 8600667070', 'wissen6@wissen.com', 'Bangalore, Karanatka'),
     (7, 'wissen7', '+91 9309958788', 'wissen7@wissen.com', 'Bangalore, Karanatka'),
     (8, 'wissen8', '+91 7741022432', 'wissen8@wissen.com', 'Bangalore, Karanatka'),
     (9, 'wissen9', '+91 8407995474', 'wissen9@wissen.com', 'Bangalore, Karanatka'),
     (10, 'wissen10', '+91 7218573771', 'wissen10@wissen.com', 'Bangalore, Karanatka'),
     (11, 'wissen11', '+91 8605651614', 'wissen11@wissen.com', 'Bangalore, Karanatka'),
     (12, 'wissen12', '+91 7218477877', 'wissen12@wissen.com', 'Bangalore, Karanatka'),
     (13, 'wissen13', '+91 8884580580', 'wissen13@wissen.com', 'Bangalore, Karanatka'),
     (14, 'wissen14', '+91 9611729155', 'wissen14@wissen.com', 'Bangalore, Karanatka'),
     (15, 'wissen15', '+91 7904715656', 'wissen15@wissen.com', 'Bangalore, Karanatka'),
     (16, 'wissen16', '+91 7020607012', 'wissen16@wissen.com', 'Bangalore, Karanatka'),
     (17, 'wissen17', '+91 8249391678', 'wissen17@wissen.com', 'Bangalore, Karanatka'),
     (18, 'wissen18', '+91 8709636881', 'wissen18@wissen.com', 'Bangalore, Karanatka'),
     (19, 'wissen19', '+91 9989339903', 'wissen19@wissen.com', 'Bangalore, Karanatka'),
     (20, 'wissen20', '+91 7823962899', 'wissen20@wissen.com', 'Bangalore, Karanatka');
     
     

     



 

