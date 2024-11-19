docker_password = ""

registry_config = [
  {
    project = "gcp-cloudrun-nodejs-mysql-app"
    # location = "US"
    location      = "us-central1"
    repository_id = "gcp-cloud-run-sql-nodejs"
    description   = "gcp cloud run sql nodejs"
    format        = "DOCKER"
  }
]


build_config = [
  {
  name = "gcp-cloudrun-nodejs-mysql-app"
  project  = "gcp-cloudrun-nodejs-mysql-app"
  disabled = false
    #uri = "https://github.com/UmeshBuraWissen/gcp-cloudrun-nodejs-mysql-terraform-infra.git"
    path = "cicd_pipelines_jenkins_ado_githubactions_gcpcloudbuild_gitlab/cloudbuild.yaml"
    # repo_type = "GITHUB"
    # revision  = "refs/heads/main"
    owner = "UmeshBuraWissen"
    github_reponame  = "projects/gcp-cloudrun-nodejs-mysql-app/locations/us-central1/connections/gcp-cloudrun-nodejs-mysql-infra/repositories/UmeshBuraWissen-gcp-cloudrun-nodejs-mysql-app-deployment"
      branch       = "^main$"
      invert_regex = false
      service_account = "serviceconnectionsrv@gcp-cloudrun-nodejs-mysql-app.iam.gserviceaccount.com"
  }
]