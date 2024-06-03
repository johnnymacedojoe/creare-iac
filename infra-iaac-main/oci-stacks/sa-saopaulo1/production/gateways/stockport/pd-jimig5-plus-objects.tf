
resource "oci_objectstorage_bucket" "pd_jimig5_plus_objects" {
  compartment_id = var.production
  name           = "PD-JimiG5-Plus-Objects"
  namespace      = var.bucket_namespace
  auto_tiering   = "InfrequentAccess"

  defined_tags = var.defined_tags_set
}


resource "oci_objectstorage_object_lifecycle_policy" "pd_jimig5_plus_objects_lifecycle" {
  bucket    = oci_objectstorage_bucket.pd_jimig5_plus_objects.name
  namespace = var.bucket_namespace

  rules {
    action      = "ARCHIVE"
    name        = "Move to Archive after 90 days"
    time_amount = 90
    time_unit   = "DAYS"
    is_enabled  = true
  }

  depends_on = [oci_objectstorage_bucket.pd_jimig5_plus_objects]
}