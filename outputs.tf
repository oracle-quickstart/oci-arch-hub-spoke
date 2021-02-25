output "bastion_public_ip" {
  value = oci_core_instance.bastion_instance.*.public_ip
}

output "vcn_id_spoke01" {
  value = oci_core_vcn.spoke01.id
}

output "vcn_id_spoke02" {
  value = oci_core_vcn.spoke02.id
}