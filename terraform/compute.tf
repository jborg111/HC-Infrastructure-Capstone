# HealthConnect private test VM
resource "google_compute_instance" "healthconnect_test_vm" {
  name         = "hc-test-vm"
  machine_type = "e2-micro"
  zone         = "${var.region}-a"

  # Firewall targeting
  tags = [
    "allow-iap-ssh",
    "allow-app-traffic"
  ]

  # Resource organization
  labels = {
    environment = "test"
    project     = "healthconnect"
    managed_by  = "terraform"
  }

  # Operating system and boot disk
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 10
      type  = "pd-standard"
    }
  }

  # Connect VM to the application subnet
  network_interface {
    network    = google_compute_network.healthconnect_vpc.id
    subnetwork = google_compute_subnetwork.app_subnet.id
  }
}