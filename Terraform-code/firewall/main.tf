resource "google_compute_network" "sre-ports" {
  name = "sre-testing-default"
}

resource "google_compute_firewall" "default-ssh" {
  name    = "default-allow-ssh"
  network = google_compute_network.sre-ports.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["ssh-server"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "default-http-https" {
  name    = "default-allow-http-https"
  network = google_compute_network.sre-ports.self_link

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  target_tags = ["web-server"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "default-mysql" {
  name    = "default-allow-mysql"
  network = google_compute_network.sre-ports.self_link

  allow {
    protocol = "tcp"
    ports    = ["3306"]
  }

  target_tags = ["db-server"]
  source_ranges = ["0.0.0.0/0"]
}
