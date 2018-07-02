#######################
#### State backend ########
#######################

terraform {
  backend "gcs" {
    bucket = "naesheim-home-terraform"
    prefix = "cluster/state"
    project = "naesheim-home"
    credentials = "credentials.json"
  }
}
