## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_vcn" "hub" {
  cidr_block     = var.hub_vcn_cidr_block
  dns_label      = var.hub_vcn_dns_label
  compartment_id = var.compartment_ocid
  display_name   = var.hub_vcn_display_name
  defined_tags   = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

#IGW
resource "oci_core_internet_gateway" "hub_internet_gateway" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.hub.id
    enabled = "true"
    display_name = "IGW_HUB"
    defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

#Default route table hub
resource "oci_core_default_route_table" "hub_default_route_table" {
    manage_default_resource_id = oci_core_vcn.hub.default_route_table_id
    route_rules {
        network_entity_id = oci_core_internet_gateway.hub_internet_gateway.id
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
    }
    route_rules {
        network_entity_id = oci_core_local_peering_gateway.hub_spoke01_local_peering_gateway.id
        destination       = var.spoke01_vcn_cidr_block
        destination_type  = "CIDR_BLOCK"
    }
    route_rules {
        network_entity_id = oci_core_local_peering_gateway.hub_spoke02_local_peering_gateway.id
        destination       = var.spoke02_vcn_cidr_block
        destination_type  = "CIDR_BLOCK"
    }
    defined_tags         = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

# Peering connections to the spokes
resource "oci_core_local_peering_gateway" "hub_spoke01_local_peering_gateway" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.hub.id
    display_name = "hub_spoke01"
    peer_id = oci_core_local_peering_gateway.spoke01_hub_local_peering_gateway.id
    defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_local_peering_gateway" "hub_spoke02_local_peering_gateway" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.hub.id
    display_name = "hub_spoke02"
    peer_id = oci_core_local_peering_gateway.spoke02_hub_local_peering_gateway.id
    defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
#Hub pub subnet
resource "oci_core_subnet" "hub_subnet_pub01" {
    cidr_block = var.hub_subnet_pub01_cidr_block
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.hub.id
    display_name = var.hub_subnet_pub01_display_name
    defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

