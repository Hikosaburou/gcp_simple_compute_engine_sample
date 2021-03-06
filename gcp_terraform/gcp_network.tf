resource "google_compute_network" "cloudiap_network" {
  name                    = "${var.project_prefix}-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "cloudiap_subnetwork" {
  name          = "${var.project_prefix}-subnetwork"
  ip_cidr_range = "10.8.0.0/16"
  region        = var.default_region
  network       = google_compute_network.cloudiap_network.id
}

resource "google_compute_route" "default_internet" {
  name = "allow-egress-internet"
  network = google_compute_network.cloudiap_network.name
  dest_range   = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
}

resource "google_compute_firewall" "cloudiap" {
  name    = "allow-ingress-from-iap"
  network = google_compute_network.cloudiap_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "3389"]
  }

  source_ranges = ["35.235.240.0/20"]

  target_tags   = [var.tag_tunnel]
}