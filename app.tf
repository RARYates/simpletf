variable "instances" {
  default = "1"
}

provider "google" {
  credentials = "${file("simple.json")}"
  project     = "simpletf"
  region      = "us-central1"
}

resource "google_compute_instance" "webapp" {
  count = var.instances
  name = "webapp-${count.index}"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["master"]

  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }

  network_interface {
    network = "${google_compute_network.app_network.name}"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  metadata_startup_script = file("scripts/web2.sh")

}

resource "google_compute_firewall" "app_firewall" {
  name = "app-firewall"
  network = "${google_compute_network.app_network.name}"

  allow {
    protocol = "tcp"
    ports   = ["80","22"]
  }

}

resource "google_compute_network" "app_network" {
  name = "app-network"
}
