resource "google_dns_managed_zone" "root_zone" {
  description = var.dns_zone_description
  dns_name    = var.dns_zone_fqdn
  name        = var.dns_zone_name
  project     = var.gcp_project

  dnssec_config {
    state = var.dnssec_enabled ? "on" : "off"
  }
}

resource "google_dns_record_set" "record_a_root" {
  count = length(var.root_a_record) > 0 ? 1 : 0

  managed_zone = google_dns_managed_zone.root_zone.name
  name         = google_dns_managed_zone.root_zone.dns_name
  project      = var.gcp_project
  rrdatas      = var.root_a_record
  ttl          = "300"
  type         = "A"

  depends_on = [
    google_dns_managed_zone.root_zone,
  ]
}

resource "google_dns_record_set" "record_a" {
  for_each = var.a_records

  managed_zone = google_dns_managed_zone.root_zone.name
  name         = "${each.key}.${google_dns_managed_zone.root_zone.dns_name}"
  project      = var.gcp_project
  rrdatas      = [each.value]
  ttl          = "300"
  type         = "A"

  depends_on = [
    google_dns_managed_zone.root_zone,
  ]
}

resource "google_dns_record_set" "record_cname" {
  for_each = var.cname_records

  managed_zone = google_dns_managed_zone.root_zone.name
  name         = "${each.key}.${google_dns_managed_zone.root_zone.dns_name}"
  project      = var.gcp_project
  rrdatas      = [each.value]
  ttl          = "300"
  type         = "CNAME"

  depends_on = [
    google_dns_managed_zone.root_zone,
  ]
}

resource "google_dns_record_set" "record_mx_root" {
  count = length(var.root_mx_records) > 0 ? 1 : 0

  managed_zone = google_dns_managed_zone.root_zone.name
  name         = google_dns_managed_zone.root_zone.dns_name
  project      = var.gcp_project
  rrdatas      = var.root_mx_records
  ttl          = "300"
  type         = "MX"

  depends_on = [
    google_dns_managed_zone.root_zone,
  ]
}

resource "google_dns_record_set" "record_mx_subdomain" {
  for_each = var.subdomain_mx_records

  managed_zone = google_dns_managed_zone.root_zone.name
  name         = "${each.key}.${google_dns_managed_zone.root_zone.dns_name}"
  project      = var.gcp_project
  rrdatas      = each.value
  ttl          = "300"
  type         = "MX"

  depends_on = [
    google_dns_managed_zone.root_zone,
  ]
}

resource "google_dns_record_set" "subzone" {
  for_each = var.subzones

  managed_zone = google_dns_managed_zone.root_zone.name
  name         = "${each.key}.${google_dns_managed_zone.root_zone.dns_name}"
  project      = var.gcp_project
  rrdatas      = each.value
  ttl          = "300"
  type         = "NS"

  depends_on = [
    google_dns_managed_zone.root_zone,
  ]
}

resource "google_dns_record_set" "root_txt_records" {
  count = length(var.root_txt_records) > 0 ? 1 : 0

  managed_zone = google_dns_managed_zone.root_zone.name
  name         = google_dns_managed_zone.root_zone.dns_name
  project      = var.gcp_project
  rrdatas      = var.root_txt_records
  ttl          = "300"
  type         = "TXT"

  depends_on = [
    google_dns_managed_zone.root_zone,
  ]
}


resource "google_dns_record_set" "record_txt" {
  for_each = var.txt_records

  managed_zone = google_dns_managed_zone.root_zone.name
  name         = "${each.key}.${google_dns_managed_zone.root_zone.dns_name}"
  project      = var.gcp_project
  rrdatas      = [each.value]
  ttl          = "300"
  type         = "TXT"

  depends_on = [
    google_dns_managed_zone.root_zone,
  ]
}
