provider "google" {
  project = var.project_id
  region  = var.region
}

variable "zones" {
  description = "List of DNS zones"
  type        = list(object({
    name          = string
    dns_name      = string
    description   = string
    cname_records = list(object({
      name  = string
      alias = string
      ttl   = number
    }))
    a_records     = list(object({
      name    = string
      address = string
      ttl     = number
    }))
    txt_records   = list(object({
      name    = string
      txt_data = string
      ttl     = number
    }))
  }))
}

resource "google_dns_managed_zone" "zones" {
  for_each = { for idx, zone in var.zones : zone.name => idx }

  name        = each.key
  dns_name    = var.zones[each.value].dns_name
  description = var.zones[each.value].description

  labels = {
    environment = "production"
  }
}

resource "google_dns_record_set" "cname_records" {
  for_each = {
    for zone in var.zones :
    "${zone.name}-cname" => zone.cname_records
  }

  managed_zone = google_dns_managed_zone.zones[each.key].name
  name         = each.value.name
  type         = "CNAME"
  ttl          = each.value.ttl
  rrdatas      = [each.value.alias]
}

resource "google_dns_record_set" "a_records" {
  for_each = {
    for zone in var.zones :
    "${zone.name}-a" => zone.a_records
  }

  managed_zone = google_dns_managed_zone.zones[each.key].name
  name         = each.value.name
  type         = "A"
  ttl          = each.value.ttl
  rrdatas      = [each.value.address]
}

resource "google_dns_record_set" "txt_records" {
  for_each = {
    for zone in var.zones :
    "${zone.name}-txt" => zone.txt_records
  }

  managed_zone = google_dns_managed_zone.zones[each.key].name
  name         = each.value.name
  type         = "TXT"
  ttl          = each.value.ttl
  rrdatas      = [each.value.txt_data]
}
