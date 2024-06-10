resource "google_compute_instance" "dbserver" {
  name = "dbserver"
  machine_type = "n2-standard-2"
  zone = "asia-east1-a"
 boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"  # Ubuntu 20.04 LTS image
    }
  }
    network_interface {
    network    = "sre-testing"
    subnetwork = "sre-team"

    access_config {}
  }

  tags = ["dbserver"]
  metadata_startup_script = file("${path.module}/db.sh")
}


  

