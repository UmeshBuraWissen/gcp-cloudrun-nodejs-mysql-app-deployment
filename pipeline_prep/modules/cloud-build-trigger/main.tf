resource "google_cloudbuild_trigger" "trigger" {
  name = var.name
  location = "us-central1"
  project  = var.project
  disabled = var.disabled
  # git_file_source {
  #   uri = var.uri
  #   path = var.path
  #   repo_type = var.repo_type
  #   revision  = var.revision
  #   }
/*   github {
    owner = var.owner
    name  = var.github_reponame
    push {
      branch       = var.branch
      #invert_regex = var.invert_regex
    }
  } */
   repository_event_config {
          repository = var.github_reponame #"projects/gcp-cloudrun-nodejs-mysql-app/locations/us-central1/connections/gcp-cloudrun-nodejs-mysql-infra/repositories/UmeshBuraWissen-gcp-cloudrun-nodejs-mysql-app-deployment" 

           push {
               branch       = var.branch #"^main$" 
               invert_regex = var.invert_regex #false 
                tag          = null
            }
        }
/*   substitutions = {
    _VERSION = "2.0.0"
  } */

  service_account = "projects/${var.project}/serviceAccounts/${var.service_account}"
  filename = var.path

  
}