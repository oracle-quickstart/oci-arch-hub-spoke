## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "bastion_public_ip" {
  value = oci_core_instance.bastion_instance.*.public_ip
}

output "vcn_id_spoke01" {
  value = oci_core_vcn.spoke01.id
}

output "vcn_id_spoke02" {
  value = oci_core_vcn.spoke02.id
}

output "generated_ssh_private_key" {
  value = tls_private_key.public_private_key_pair.private_key_pem
}