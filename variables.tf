## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "region" {}
variable "fingerprint" {}
variable "user_ocid" {}
variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "private_key_path" {}
variable "availablity_domain_name" {}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.1"
}

variable "igw_display_name" {
  default = "internet-gateway"
}

variable "hub_vcn_cidr_block" {
  default = "10.0.0.0/16"
}
variable "hub_vcn_dns_label" {
  default = "hubvcn"
}
variable "hub_vcn_display_name" {
  default = "hub_vcn"
}

variable "hub_subnet_pub01_cidr_block" {
  default = "10.0.0.0/24"
}

variable "hub_subnet_pub01_display_name" {
  default = "hub_subnet_pub01"
}

# spoke01
variable "spoke01_vcn_cidr_block" {
  default = "10.10.0.0/16"
}
variable "spoke01_vcn_dns_label" {
  default = "spoke01vcn"
}
variable "spoke01_vcn_display_name" {
  default = "spoke01_vcn"
}
variable "spoke01_subnet_priv01_cidr_block" {
  default = "10.10.0.0/24"
}
variable "spoke01_subnet_priv01_display_name" {
  default = "spoke01_subnet_priv01"
}

# spoke02
variable "spoke02_vcn_cidr_block" {
  default = "10.20.0.0/16"
}
variable "spoke02_vcn_dns_label" {
  default = "spoke02vcn"
}
variable "spoke02_vcn_display_name" {
  default = "spoke02_vcn"
}

variable "spoke02_subnet_priv01_cidr_block" {
  default = "10.20.0.0/24"
}

variable "spoke02_subnet_priv01_display_name" {
  default = "spoke02_subnet_priv01"
}

variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
#  default     = "7.9"
  default     = "8"
}

variable "InstanceShape" {
    default = "VM.Standard.E3.Flex"
}

variable "InstanceFlexShapeOCPUS" {
    default = 1
}

variable "InstanceFlexShapeMemory" {
    default = 10
}

variable "ssh_public_key" {
  default = ""
}

variable "deploy_spoke01_instance" {
  default = false
}

variable "InstanceShapeSpoke01" {
    default = "VM.Standard.E3.Flex"
}

variable "InstanceFlexShapeOCPUSSpoke01" {
    default = 1
}

variable "InstanceFlexShapeMemorySpoke01" {
    default = 10
}

variable "deploy_spoke02_instance" {
  default = false
}

variable "InstanceShapeSpoke02" {
    default = "VM.Standard.E3.Flex"
}

variable "InstanceFlexShapeOCPUSSpoke02" {
    default = 1
}

variable "InstanceFlexShapeMemorySpoke02" {
    default = 10
}

# Dictionary Locals
locals {
  compute_flexible_shapes = [
    "VM.Standard.E3.Flex",
    "VM.Standard.E4.Flex"
  ]
}

# Checks if is using Flexible Compute Shapes
locals {
  is_flexible_node_shape = contains(local.compute_flexible_shapes, var.InstanceShape)
  is_flexible_node_shape_spoke01 = contains(local.compute_flexible_shapes, var.InstanceShapeSpoke01)
  is_flexible_node_shape_spoke02 = contains(local.compute_flexible_shapes, var.InstanceShapeSpoke02)
}
