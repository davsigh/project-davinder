resource "google_compute_backend_service" "default" {
  name                  = "web-backend-service"
  health_checks         = [google_compute_health_check.web_health_check.id]
  load_balancing_scheme = "EXTERNAL"

  backend {
    group = var.backend_group
  }
}

resource "google_compute_url_map" "default" {
  name            = "web-url-map"
  default_service = google_compute_backend_service.default.self_link
}

resource "google_compute_target_http_proxy" "default" {
  name    = "web-http-proxy"
  url_map = google_compute_url_map.default.self_link
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "web-forwarding-rule"
  target     = google_compute_target_http_proxy.default.self_link
  port_range = "80"
}

resource "google_compute_health_check" "web_health_check" {
  name = "web-health-check-unique"

  http_health_check {
    request_path = "/"
    port         = 80
  }

  check_interval_sec   = 5
  timeout_sec          = 5
  healthy_threshold    = 2
  unhealthy_threshold  = 2
}
