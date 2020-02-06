data "oci_identity_availability_domains" "ads" {
  compartment_id = "${var.tenancy_ocid}"
}

# Output the result
output "show-ads" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}


data "oci_identity_availability_domain" "default_AD" {
    #Required
    compartment_id = var.tenancy_ocid

    # #Optional (one or the other is required)
    # id = "${var.id}"
    ad_number = 2
}

output "default_AD" {
    value = data.oci_identity_availability_domain.default_AD.name
}

# data "oci_core_shapes" "test_shapes" {
#     #Required
#     compartment_id = var.compartment_ocid

#     #Optional
#     # availability_domain = "${var.shape_availability_domain}"
#     # image_id = "${oci_core_image.test_image.id}"
# }

# output "my_shapes" {
#     value = data.oci_core_shapes.test_shapes.shapes
# }

output "default_region" {
  value = var.region
}