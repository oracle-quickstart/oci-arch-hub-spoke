## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

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


# OS Images
variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "7.7"
}

# Defines the number of instances to deploy
variable "NumInstances" {
    default = "1"
}

variable "InstanceShape" {
    default = "VM.Standard2.1"
}
