

data "google_client_config" "default" {
}

provider "google" {
  project = "ace-resolver-422807-t7"
  region  = "europe-west4"
  zone    = "europe-west4-b"
}
