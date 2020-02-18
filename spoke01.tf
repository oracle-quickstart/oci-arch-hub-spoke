resource "oci_core_vcn" "spoke01" {
  cidr_block     = "10.10.0.0/16"
  dns_label      = "spoke01"
  compartment_id = var.compartment_ocid
  display_name   = "spoke01"
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
resource "oci_core_subnet" "spoke01_subnet_pub01" {
    cidr_block = "10.10.10.0/24"
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.spoke01.id
    display_name = "spoke1_subnet_pub01"
}

output "vcn_id_spoke01" {
  value = oci_core_vcn.spoke01.id
}

resource "oci_core_instance" "spoke01_test_instance" {
  # count = var.NumInstances
  availability_domain = data.oci_identity_availability_domain.default_AD.name
  compartment_id = var.compartment_ocid
  display_name = "spoke01_test_instance"
  shape = var.InstanceShape

  create_vnic_details {
    subnet_id = oci_core_subnet.spoke01_subnet_pub01.id
    display_name = "primaryvnic"
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id = var.InstanceImageOCID[var.region]

  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  
  }
  # timeouts {
  #   create = "60m"
  # }
}