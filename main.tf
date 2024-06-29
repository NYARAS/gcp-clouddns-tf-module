module "gcp_cloud_dns_managed_zone" {
  source = "./dns"

  a_records            = var.a_records
  cname_records        = var.cname_records
  dns_zone_description = var.dns_zone_description
  dns_zone_fqdn        = var.dns_zone_fqdn
  dns_zone_name        = var.dns_zone_name
  dnssec_enabled       = var.dnssec_enabled
  gcp_project          = var.gcp_project
  root_a_record        = var.root_a_record
  root_mx_records      = var.root_mx_records
  subdomain_mx_records = var.subdomain_mx_records
  subzones             = var.subzones
  txt_records          = var.txt_records
  root_txt_records     = var.root_txt_records
}
