# gcloud compute addresses create k8s-advertised-ip --project=k8s-playfield --description=k8s-advertised-ip --global

resource "google_compute_global_address" "k8s-advertised-ip" {
  name         = "k8s-advertised-ip"
  description  = "k8s-advertised-ip"
  project      = "k8s-playfield"
  address_type = "EXTERNAL"
  ip_version   = "IPV6"
}