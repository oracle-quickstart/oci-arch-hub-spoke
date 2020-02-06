variable "region" {}
variable "private_key_path" {}
variable "ssh_public_key" {}
variable "fingerprint" {}
variable "user_ocid" {}
variable "tenancy_ocid" {}
variable "compartment_ocid" {
}
variable "vcn_cidr_block" {
  default = ""
}
variable "vcn_dns_label" {
  default = "vcn"
}
variable "vcn_display_name" {
  default = "vcn"
}
variable "igw_display_name" {
  default = "internet-gateway"
}

# variable "subnet_cidr_block" {}

variable "subnet_display_name" {
  default = "subnet"
}

variable "subnet_dns_label" {
  default = "subnet"
}

variable "use_existing_network" {
  type = bool
  default = false
}

variable "vcn_id" {  
  default = ""
}

variable "subnet_id" {
  default = ""
}

variable "InstanceImageOCID" {
    type = map(string)
    default = {
        // See https://docs.cloud.oracle.com/images/
        // Oracle-provided image "Oracle-Autonomous-Linux-7.7-2020.01-0"
        us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaasrjyeax4sznb3jxnamxrjpgiw2ked3isrmj6ktu44uso4mln7dua"
        us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaaioy3pwjguhyxmp7gmfp534hmz27o7yfdt4b23qgs7ypr52k3zk5q"
    }
}


# Defines the number of instances to deploy
variable "NumInstances" {
    default = "1"
}

variable "InstanceShape" {
    default = "VM.Standard.E2.1"
}
