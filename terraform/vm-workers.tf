locals {
  vm_count = 3
}

resource "google_compute_instance" "k8s_coordinator" {
  count = local.vm_count

  boot_disk {
    auto_delete = true
    initialize_params {
      image = "projects/debian-cloud/global/images/debian-11-bullseye-v20231212"
      size  = 60
      type  = "pd-standard"
    }
  }

  name         = "k8s-coordinator-${count.index + 1}"
  machine_type = "n1-standard-2"
  zone         = "us-west1-c"
  project      = "k8s-playfield"

  network_interface {
    network    = "k8s-network"
    subnetwork = "projects/k8s-playfield/regions/us-west1/subnetworks/nodes-us-west1"
    network_ip = "10.240.0.1${count.index + 1}"
  }

  tags = ["k8s-network", "k8s-worker"]

  deletion_protection = false
  enable_display      = false
  can_ip_forward      = true

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email = "288446609233-compute@developer.gserviceaccount.com"
    scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append"
    ]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }
}