variable "dns_zone_description" {
  type        = string
  description = "Cloud DNS Module for GCP."
  default     = "Created with the gcp-cloud-dns-managed-zone-tf-module"
}

variable "dns_zone_fqdn" {
  type        = string
  description = "The FQDN of the DNS zone with a trailing period (Example: domain.tld.)"
}

variable "dns_zone_name" {
  type        = string
  description = "The slug name of the DNS zone (Example: domain-tld-zone)"
}

variable "dnssec_enabled" {
  type        = bool
  description = "Enable DNSSEC for this managed zone with default secure configuration."
  default     = true
}

variable "gcp_project" {
  type        = string
  description = "The GCP project ID (may be an alphanumeric slug) that the resources are deployed in. (Example: my-project-name)"
}

variable "root_a_record" {
  type        = list(string)
  description = "A map with the root A record configuration."
  default     = ["1.2.3.4"]

}
variable "a_records" {
  type        = map(any)
  description = "A map with record name and IP address value."
  default     = {}
}

variable "cname_records" {
  type        = map(any)
  description = "A map with record name and CNAME value."
  default     = {}
}

variable "root_mx_records" {
  type        = list(any)
  description = "A list with MX values for top-level domain."
  default     = []
}

variable "subdomain_mx_records" {
  type        = map(any)
  description = "A map with MX record name and MX value list for subdomains"
  default     = {}
}

variable "subzones" {
  type        = map(any)
  description = "A map with the subdomain name and a list of name servers that host the subzone configuration."
  default     = {}
}

variable "txt_records" {
  type        = map(any)
  description = "A map with TXT record name and TXT value"
  default     = {}
}

variable "root_txt_records" {
  type        = list(any)
  description = "A list with TXT values for top-level domain."
  default     = []
}
