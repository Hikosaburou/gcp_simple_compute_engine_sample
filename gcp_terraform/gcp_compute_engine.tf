resource "google_compute_instance" "default" {
  name         = "${var.project_prefix}-vm"
  machine_type = var.instance_type
  zone         = var.default_zone

  tags = [var.tag_tunnel]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.cloudiap_subnetwork.name
    // External IPは不要なので access_config は設定しない
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}