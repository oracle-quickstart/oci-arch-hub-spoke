## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

data "template_file" "key_script" {
  template = file("./scripts/sshkey.tpl")
  vars = {
    ssh_public_key = tls_private_key.public_private_key_pair.public_key_openssh
  }
}

data "template_cloudinit_config" "cloud_init" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "ainit.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.key_script.rendered
  }
}

# Bastion VM

resource "oci_core_instance" "bastion_instance" {
  availability_domain = var.availablity_domain_name
  compartment_id      = var.compartment_ocid
  display_name        = "BastionVM"
  shape               = var.InstanceShape
  
  dynamic "shape_config" {
    for_each = local.is_flexible_node_shape ? [1] : []
    content {
      memory_in_gbs = var.InstanceFlexShapeMemory
      ocpus = var.InstanceFlexShapeOCPUS
    }
  }
  
  create_vnic_details {
    subnet_id = oci_core_subnet.hub_subnet_pub01.id
    display_name = "primaryvnic"
    assign_public_ip = true
  }

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = data.template_cloudinit_config.cloud_init.rendered
  }

  
  defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}


 resource "oci_core_instance" "spoke01_test_instance" {
   count               = var.deploy_spoke01_instance ? 1 : 0
   availability_domain = var.availablity_domain_name
   compartment_id      = var.compartment_ocid
   display_name        = "spoke01_test_instance"
   shape               = var.InstanceShapeSpoke01

   dynamic "shape_config" {
     for_each = local.is_flexible_node_shape_spoke01 ? [1] : []
     content {
       memory_in_gbs = var.InstanceFlexShapeMemorySpoke01
       ocpus = var.InstanceFlexShapeOCPUSSpoke01
     }
   }

   create_vnic_details {
     subnet_id = oci_core_subnet.spoke01_subnet_priv01.id
     display_name = "primaryvnic"
     assign_public_ip = false
   }

   source_details {
     source_type             = "image"
     source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
     boot_volume_size_in_gbs = "50"
   }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = data.template_cloudinit_config.cloud_init.rendered
  }
}



 resource "oci_core_instance" "spoke02_test_instance" {
   count               = var.deploy_spoke01_instance ? 1 : 0
   availability_domain = var.availablity_domain_name
   compartment_id      = var.compartment_ocid
   display_name        = "spoke02_test_instance"
   shape               = var.InstanceShapeSpoke02

   dynamic "shape_config" {
     for_each = local.is_flexible_node_shape_spoke02 ? [1] : []
     content {
       memory_in_gbs = var.InstanceFlexShapeMemorySpoke02
       ocpus = var.InstanceFlexShapeOCPUSSpoke02
     }
   }

   create_vnic_details {
     subnet_id = oci_core_subnet.spoke02_subnet_priv01.id
     display_name = "primaryvnic"
     assign_public_ip = false
   }

   source_details {
     source_type             = "image"
     source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
     boot_volume_size_in_gbs = "50"
   }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = data.template_cloudinit_config.cloud_init.rendered
  }
}
