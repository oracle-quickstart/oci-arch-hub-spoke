## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_vcn" "spoke01" {
  cidr_block     = var.spoke01_vcn_cidr_block
  dns_label      = var.spoke01_vcn_dns_label
  compartment_id = var.compartment_ocid
  display_name   = var.spoke01_vcn_display_name
}
#LPG Spoke-HUB
resource "oci_core_local_peering_gateway" "spoke01_hub_local_peering_gateway" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.spoke01.id
    display_name = "spoke01_hub_lpg"
}

#Default route table spoke01
resource "oci_core_default_route_table" "spoke01_default_route_table" {
    manage_default_resource_id = oci_core_vcn.spoke01.default_route_table_id
    route_rules {
        network_entity_id = oci_core_local_peering_gateway.spoke01_hub_local_peering_gateway.id
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
    }
}
resource "oci_core_subnet" "spoke01_subnet_priv01" {
    cidr_block = var.spoke01_subnet_priv01_cidr_block
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.spoke01.id
    display_name = var.spoke01_subnet_priv01_display_name
}

output "vcn_id_spoke01" {
  value = oci_core_vcn.spoke01.id
}

# resource "oci_core_instance" "spoke01_test_instance" {
#   availability_domain = data.oci_identity_availability_domains.ADs.availability_domains[0]["name"]
#   compartment_id = var.compartment_ocid
#   display_name = "spoke01_test_instance"
#   shape = var.InstanceShape

#   create_vnic_details {
#     subnet_id = oci_core_subnet.spoke01_subnet_priv01.id
#     display_name = "primaryvnic"
#     assign_public_ip = false
#   }

#   source_details {
#     source_type             = "image"
#     source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
#     boot_volume_size_in_gbs = "50"
#   }

#   metadata = {
#     ssh_authorized_keys = var.ssh_public_key
#   }
#   # timeouts {
#   #   create = "60m"
#   # }
# }