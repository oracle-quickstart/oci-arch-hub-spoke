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

data "oci_marketplace_listings" "test_listings" {

    # #Optional
    # category = "${var.listing_category}"
    # is_featured = "${var.listing_is_featured}"
    # listing_id = "${oci_marketplace_listing.test_listing.id}"
    # name = "${var.listing_name}"
    # package_type = "${var.listing_package_type}"
    # pricing = "${var.listing_pricing}"
    # publisher_id = "${oci_marketplace_publisher.test_publisher.id}"
}

output "listing" {
  
}