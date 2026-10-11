resource "aws_s3_bucket" "s3_buckets" {
  for_each = var.s3_buckets

  acceleration_status = each.value.acceleration_status
  acl                 = each.value.acl
  bucket              = each.value.bucket
  bucket_namespace    = each.value.bucket_namespace
  bucket_prefix       = each.value.bucket_prefix
  force_destroy       = each.value.force_destroy
  object_lock_enabled = each.value.object_lock_enabled
  policy              = each.value.policy
  region              = each.value.region
  request_payer       = each.value.request_payer
  tags                = each.value.tags
  tags_all            = each.value.tags_all

  dynamic "cors_rule" {
    for_each = each.value.cors_rule != null ? each.value.cors_rule : []
    content {
      allowed_headers = cors_rule.value.allowed_headers
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      expose_headers  = cors_rule.value.expose_headers
      max_age_seconds = cors_rule.value.max_age_seconds
    }
  }

  dynamic "grant" {
    for_each = each.value.grant != null ? each.value.grant : []
    content {
      id          = grant.value.id
      permissions = grant.value.permissions
      type        = grant.value.type
      uri         = grant.value.uri
    }
  }

  dynamic "lifecycle_rule" {
    for_each = each.value.lifecycle_rule != null ? each.value.lifecycle_rule : []
    content {
      abort_incomplete_multipart_upload_days = lifecycle_rule.value.abort_incomplete_multipart_upload_days
      enabled                                = lifecycle_rule.value.enabled
      dynamic "expiration" {
        for_each = lifecycle_rule.value.expiration != null ? [lifecycle_rule.value.expiration] : []
        content {
          date                         = expiration.value.date
          days                         = expiration.value.days
          expired_object_delete_marker = expiration.value.expired_object_delete_marker
        }
      }
      id = lifecycle_rule.value.id
      dynamic "noncurrent_version_expiration" {
        for_each = lifecycle_rule.value.noncurrent_version_expiration != null ? [lifecycle_rule.value.noncurrent_version_expiration] : []
        content {
          days = noncurrent_version_expiration.value.days
        }
      }
      dynamic "noncurrent_version_transition" {
        for_each = lifecycle_rule.value.noncurrent_version_transition != null ? lifecycle_rule.value.noncurrent_version_transition : []
        content {
          days          = noncurrent_version_transition.value.days
          storage_class = noncurrent_version_transition.value.storage_class
        }
      }
      prefix = lifecycle_rule.value.prefix
      tags   = lifecycle_rule.value.tags
      dynamic "transition" {
        for_each = lifecycle_rule.value.transition != null ? lifecycle_rule.value.transition : []
        content {
          date          = transition.value.date
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }
    }
  }

  dynamic "logging" {
    for_each = each.value.logging != null ? [each.value.logging] : []
    content {
      target_bucket = logging.value.target_bucket
      target_prefix = logging.value.target_prefix
    }
  }

  dynamic "object_lock_configuration" {
    for_each = each.value.object_lock_configuration != null ? [each.value.object_lock_configuration] : []
    content {
      object_lock_enabled = object_lock_configuration.value.object_lock_enabled
      dynamic "rule" {
        for_each = object_lock_configuration.value.rule != null ? [object_lock_configuration.value.rule] : []
        content {
          default_retention {
            days  = rule.value.default_retention.days
            mode  = rule.value.default_retention.mode
            years = rule.value.default_retention.years
          }
        }
      }
    }
  }

  dynamic "replication_configuration" {
    for_each = each.value.replication_configuration != null ? [each.value.replication_configuration] : []
    content {
      role = replication_configuration.value.role
      dynamic "rules" {
        for_each = replication_configuration.value.rules
        content {
          delete_marker_replication_status = rules.value.delete_marker_replication_status
          destination {
            dynamic "access_control_translation" {
              for_each = rules.value.destination.access_control_translation != null ? [rules.value.destination.access_control_translation] : []
              content {
                owner = access_control_translation.value.owner
              }
            }
            account_id = rules.value.destination.account_id
            bucket     = rules.value.destination.bucket
            dynamic "metrics" {
              for_each = rules.value.destination.metrics != null ? [rules.value.destination.metrics] : []
              content {
                minutes = metrics.value.minutes
                status  = metrics.value.status
              }
            }
            replica_kms_key_id = rules.value.destination.replica_kms_key_id
            dynamic "replication_time" {
              for_each = rules.value.destination.replication_time != null ? [rules.value.destination.replication_time] : []
              content {
                minutes = replication_time.value.minutes
                status  = replication_time.value.status
              }
            }
            storage_class = rules.value.destination.storage_class
          }
          dynamic "filter" {
            for_each = rules.value.filter != null ? [rules.value.filter] : []
            content {
              prefix = filter.value.prefix
              tags   = filter.value.tags
            }
          }
          id       = rules.value.id
          prefix   = rules.value.prefix
          priority = rules.value.priority
          dynamic "source_selection_criteria" {
            for_each = rules.value.source_selection_criteria != null ? [rules.value.source_selection_criteria] : []
            content {
              dynamic "sse_kms_encrypted_objects" {
                for_each = source_selection_criteria.value.sse_kms_encrypted_objects != null ? [source_selection_criteria.value.sse_kms_encrypted_objects] : []
                content {
                  enabled = sse_kms_encrypted_objects.value.enabled
                }
              }
            }
          }
          status = rules.value.status
        }
      }
    }
  }

  dynamic "server_side_encryption_configuration" {
    for_each = each.value.server_side_encryption_configuration != null ? [each.value.server_side_encryption_configuration] : []
    content {
      rule {
        apply_server_side_encryption_by_default {
          kms_master_key_id = server_side_encryption_configuration.value.rule.apply_server_side_encryption_by_default.kms_master_key_id
          sse_algorithm     = server_side_encryption_configuration.value.rule.apply_server_side_encryption_by_default.sse_algorithm
        }
        bucket_key_enabled = server_side_encryption_configuration.value.rule.bucket_key_enabled
      }
    }
  }

  dynamic "versioning" {
    for_each = each.value.versioning != null ? [each.value.versioning] : []
    content {
      enabled    = versioning.value.enabled
      mfa_delete = versioning.value.mfa_delete
    }
  }

  dynamic "website" {
    for_each = each.value.website != null ? [each.value.website] : []
    content {
      error_document           = website.value.error_document
      index_document           = website.value.index_document
      redirect_all_requests_to = website.value.redirect_all_requests_to
      routing_rules            = website.value.routing_rules
    }
  }
}

