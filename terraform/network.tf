
# HealthConnect custom VPC
resource "google_compute_network" "healthconnect_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Public subnet
resource "google_compute_subnetwork" "public_subnet" {
  name          = "hc-public-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.healthconnect_vpc.id
}

# Application subnet
resource "google_compute_subnetwork" "app_subnet" {
  name          = "hc-app-subnet"
  ip_cidr_range = "10.0.2.0/24"
  region        = var.region
  network       = google_compute_network.healthconnect_vpc.id
}

# Data subnet
resource "google_compute_subnetwork" "data_subnet" {
  name          = "hc-data-subnet"
  ip_cidr_range = "10.0.3.0/24"
  region        = var.region
  network       = google_compute_network.healthconnect_vpc.id
}

# HealthConnect Cloud Router
resource "google_compute_router" "healthconnect_router" {
  name    = "hc-cloud-router"
  region  = var.region
  network = google_compute_network.healthconnect_vpc.id
}

# HealthConnect Cloud NAT
resource "google_compute_router_nat" "healthconnect_nat" {
  name                               = "hc-cloud-nat"
  router                             = google_compute_router.healthconnect_router.name
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option             = "AUTO_ONLY"
}

# Allow SSH through Identity-Aware Proxy
resource "google_compute_firewall" "allow_iap_ssh" {
  name          = "hc-allow-iap-ssh"
  network       = google_compute_network.healthconnect_vpc.name
  direction     = "INGRESS"
  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["allow-iap-ssh"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

# Allow application traffic from the public subnet
resource "google_compute_firewall" "allow_app_traffic" {
  name          = "hc-allow-app-traffic"
  network       = google_compute_network.healthconnect_vpc.name
  direction     = "INGRESS"
  source_ranges = ["10.0.1.0/24"]
  target_tags   = ["allow-app-traffic"]

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
}
