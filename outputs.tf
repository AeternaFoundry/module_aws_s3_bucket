output "s3_buckets_id" {
  description = "Map of id values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.id if v.id != null && length(v.id) > 0 }
}
output "s3_buckets_acceleration_status" {
  description = "Map of acceleration_status values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.acceleration_status if v.acceleration_status != null && length(v.acceleration_status) > 0 }
}
output "s3_buckets_acl" {
  description = "Map of acl values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.acl if v.acl != null && length(v.acl) > 0 }
}
output "s3_buckets_arn" {
  description = "Map of arn values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "s3_buckets_bucket" {
  description = "Map of bucket values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.bucket if v.bucket != null && length(v.bucket) > 0 }
}
output "s3_buckets_bucket_domain_name" {
  description = "Map of bucket_domain_name values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.bucket_domain_name if v.bucket_domain_name != null && length(v.bucket_domain_name) > 0 }
}
output "s3_buckets_bucket_namespace" {
  description = "Map of bucket_namespace values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.bucket_namespace if v.bucket_namespace != null && length(v.bucket_namespace) > 0 }
}
output "s3_buckets_bucket_prefix" {
  description = "Map of bucket_prefix values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.bucket_prefix if v.bucket_prefix != null && length(v.bucket_prefix) > 0 }
}
output "s3_buckets_bucket_region" {
  description = "Map of bucket_region values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.bucket_region if v.bucket_region != null && length(v.bucket_region) > 0 }
}
output "s3_buckets_bucket_regional_domain_name" {
  description = "Map of bucket_regional_domain_name values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.bucket_regional_domain_name if v.bucket_regional_domain_name != null && length(v.bucket_regional_domain_name) > 0 }
}
output "s3_buckets_cors_rule" {
  description = "Map of cors_rule values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.cors_rule if v.cors_rule != null && length(v.cors_rule) > 0 }
}
output "s3_buckets_force_destroy" {
  description = "Map of force_destroy values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.force_destroy if v.force_destroy != null }
}
output "s3_buckets_grant" {
  description = "Map of grant values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.grant if v.grant != null && length(v.grant) > 0 }
}
output "s3_buckets_hosted_zone_id" {
  description = "Map of hosted_zone_id values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.hosted_zone_id if v.hosted_zone_id != null && length(v.hosted_zone_id) > 0 }
}
output "s3_buckets_lifecycle_rule" {
  description = "Map of lifecycle_rule values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.lifecycle_rule if v.lifecycle_rule != null && length(v.lifecycle_rule) > 0 }
}
output "s3_buckets_logging" {
  description = "Map of logging values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => one(v.logging) if v.logging != null && length(v.logging) > 0 }
}
output "s3_buckets_object_lock_configuration" {
  description = "Map of object_lock_configuration values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => one(v.object_lock_configuration) if v.object_lock_configuration != null && length(v.object_lock_configuration) > 0 }
}
output "s3_buckets_object_lock_enabled" {
  description = "Map of object_lock_enabled values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.object_lock_enabled if v.object_lock_enabled != null }
}
output "s3_buckets_policy" {
  description = "Map of policy values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.policy if v.policy != null && length(v.policy) > 0 }
}
output "s3_buckets_region" {
  description = "Map of region values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.region if v.region != null && length(v.region) > 0 }
}
output "s3_buckets_replication_configuration" {
  description = "Map of replication_configuration values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => one(v.replication_configuration) if v.replication_configuration != null && length(v.replication_configuration) > 0 }
}
output "s3_buckets_request_payer" {
  description = "Map of request_payer values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.request_payer if v.request_payer != null && length(v.request_payer) > 0 }
}
output "s3_buckets_server_side_encryption_configuration" {
  description = "Map of server_side_encryption_configuration values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => one(v.server_side_encryption_configuration) if v.server_side_encryption_configuration != null && length(v.server_side_encryption_configuration) > 0 }
}
output "s3_buckets_tags" {
  description = "Map of tags values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "s3_buckets_tags_all" {
  description = "Map of tags_all values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}
output "s3_buckets_versioning" {
  description = "Map of versioning values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => one(v.versioning) if v.versioning != null && length(v.versioning) > 0 }
}
output "s3_buckets_website" {
  description = "Map of website values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => one(v.website) if v.website != null && length(v.website) > 0 }
}
output "s3_buckets_website_domain" {
  description = "Map of website_domain values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.website_domain if v.website_domain != null && length(v.website_domain) > 0 }
}
output "s3_buckets_website_endpoint" {
  description = "Map of website_endpoint values across all s3_buckets, keyed the same as var.s3_buckets"
  value       = { for k, v in aws_s3_bucket.s3_buckets : k => v.website_endpoint if v.website_endpoint != null && length(v.website_endpoint) > 0 }
}

