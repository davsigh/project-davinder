resource "google_compute_instance_template" "webserver" {
  name         = "webserver-template"
  machine_type = "n2-standard-2"  # Change to your desired machine type

  disk {
    boot       = true
    auto_delete = true
    source_image = "ubuntu-os-cloud/ubuntu-2004-lts"
  }

  network_interface {
    network    = "sre-testing"
    subnetwork = "sre-team"
    access_config {}
  }
   
  metadata_startup_script = file("${path.module}/webserver.sh")
  tags = ["webserver"]
}

resource "google_compute_instance_group_manager" "webserver_group" {
  name               = "webserver-group"
  zone               = "asia-east1-a"  # Change to your desired zone
  base_instance_name = "webserver"
  //instance_template  = google_compute_instance_template.webserver.id
  target_size        = 2

   version {
    instance_template = google_compute_instance_template.webserver.id
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.web_health_check.self_link
    initial_delay_sec = 300
  }
}

resource "google_compute_autoscaler" "webserver_autoscaler" {
  name    = "webserver-autoscaler"
  zone    = "asia-east1-a"  # Change to your desired zone
  target  = google_compute_instance_group_manager.webserver_group.self_link

  autoscaling_policy {
    min_replicas    = 2
    max_replicas    = 4
    cooldown_period = 60

    cpu_utilization {
      target = 0.6
    }
  }
}

resource "google_compute_health_check" "web_health_check" {
  name = "web-health-check"

  http_health_check {
    request_path = "/"
    port         = 80
  }

  check_interval_sec   = 5
  timeout_sec          = 5
  healthy_threshold    = 2
  unhealthy_threshold  = 2
}




  

