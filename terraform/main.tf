
#######################
#### Variables ########
#######################

variable "cluster_username" {
  type        = "string"
  description = "cluster username."
  default     = "admin"
}

variable "cluster_password" {
  type        = "string"
  description = "password for the cluster username."
}

variable "issue_client_certificate" {
  type        = "string"
  description = "whether to generate client certificate or not."
  default     = "true"
}

variable "region" {
  default = "europe-west1"
}
variable "zone" {
  default = "europe-west1-b"
}
variable "cluster_name" {
    default = "naesheim-private-cluster"
}

variable "project_name" {
   default = "naesheim-home"
}

#######################
#### Provider ########
#######################
provider "google" {
  project = "${var.project_name}"
  region = "${var.region}"
}

#######################
#### Cluster ########
#######################
resource "google_container_cluster" "primary" {
  name = "${var.cluster_name}"
  zone = "${var.zone}"
  remove_default_node_pool = true
  lifecycle {
    ignore_changes = ["node_pool"]
  }

  node_pool {
    name = "default-pool"
  }

  master_auth {
    username = "${var.cluster_username}"
    password = "${var.cluster_password}"

    client_certificate_config {
      issue_client_certificate = "${var.issue_client_certificate}"
    }
  }
}

#######################
#### Node pool ########
#######################

resource "google_container_node_pool" "primary_pool" {
  name = "primary-pool"
  zone = "${var.zone}"
  cluster = "${google_container_cluster.primary.name}"

  initial_node_count = "1"

  node_config {
    machine_type = "n1-standard-1"

    oauth_scopes = [
      "compute-rw",
      "storage-ro",
      "logging-write",
      "monitoring",
    ]
  }

  management {
    auto_repair = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }
}
