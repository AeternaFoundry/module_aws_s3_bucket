variable "s3_buckets" {
  description = <<EOT
Map of s3_buckets, attributes below
Optional:
    - acceleration_status
    - acl
    - bucket
    - bucket_namespace
    - bucket_prefix
    - force_destroy
    - object_lock_enabled
    - policy
    - region
    - request_payer
    - tags
    - tags_all
    - cors_rule (block):
        - allowed_headers (optional)
        - allowed_methods (required)
        - allowed_origins (required)
        - expose_headers (optional)
        - max_age_seconds (optional)
    - grant (block):
        - id (optional)
        - permissions (required)
        - type (required)
        - uri (optional)
    - lifecycle_rule (block):
        - abort_incomplete_multipart_upload_days (optional)
        - enabled (required)
        - expiration (optional, block):
            - date (optional)
            - days (optional)
            - expired_object_delete_marker (optional)
        - id (optional)
        - noncurrent_version_expiration (optional, block):
            - days (optional)
        - noncurrent_version_transition (optional, block):
            - days (optional)
            - storage_class (required)
        - prefix (optional)
        - tags (optional)
        - transition (optional, block):
            - date (optional)
            - days (optional)
            - storage_class (required)
    - logging (block):
        - target_bucket (required)
        - target_prefix (optional)
    - object_lock_configuration (block):
        - object_lock_enabled (optional)
        - rule (optional, block):
            - default_retention (required, block):
                - days (optional)
                - mode (required)
                - years (optional)
    - replication_configuration (block):
        - role (required)
        - rules (required, block):
            - delete_marker_replication_status (optional)
            - destination (required, block):
                - access_control_translation (optional, block):
                    - owner (required)
                - account_id (optional)
                - bucket (required)
                - metrics (optional, block):
                    - minutes (optional)
                    - status (optional)
                - replica_kms_key_id (optional)
                - replication_time (optional, block):
                    - minutes (optional)
                    - status (optional)
                - storage_class (optional)
            - filter (optional, block):
                - prefix (optional)
                - tags (optional)
            - id (optional)
            - prefix (optional)
            - priority (optional)
            - source_selection_criteria (optional, block):
                - sse_kms_encrypted_objects (optional, block):
                    - enabled (required)
            - status (required)
    - server_side_encryption_configuration (block):
        - rule (required, block):
            - apply_server_side_encryption_by_default (required, block):
                - kms_master_key_id (optional)
                - sse_algorithm (required)
            - bucket_key_enabled (optional)
    - versioning (block):
        - enabled (optional)
        - mfa_delete (optional)
    - website (block):
        - error_document (optional)
        - index_document (optional)
        - redirect_all_requests_to (optional)
        - routing_rules (optional)
EOT

  type = map(object({
    acceleration_status = optional(string)
    acl                 = optional(string)
    bucket              = optional(string)
    bucket_namespace    = optional(string)
    bucket_prefix       = optional(string)
    force_destroy       = optional(bool)
    object_lock_enabled = optional(bool)
    policy              = optional(string)
    region              = optional(string)
    request_payer       = optional(string)
    tags                = optional(map(string))
    tags_all            = optional(map(string))
    cors_rule = optional(list(object({
      allowed_headers = optional(list(string))
      allowed_methods = list(string)
      allowed_origins = list(string)
      expose_headers  = optional(list(string))
      max_age_seconds = optional(number)
    })))
    grant = optional(list(object({
      id          = optional(string)
      permissions = set(string)
      type        = string
      uri         = optional(string)
    })))
    lifecycle_rule = optional(list(object({
      abort_incomplete_multipart_upload_days = optional(number)
      enabled                                = bool
      expiration = optional(object({
        date                         = optional(string)
        days                         = optional(number)
        expired_object_delete_marker = optional(bool)
      }))
      id = optional(string)
      noncurrent_version_expiration = optional(object({
        days = optional(number)
      }))
      noncurrent_version_transition = optional(list(object({
        days          = optional(number)
        storage_class = string
      })))
      prefix = optional(string)
      tags   = optional(map(string))
      transition = optional(list(object({
        date          = optional(string)
        days          = optional(number)
        storage_class = string
      })))
    })))
    logging = optional(object({
      target_bucket = string
      target_prefix = optional(string)
    }))
    object_lock_configuration = optional(object({
      object_lock_enabled = optional(string)
      rule = optional(object({
        default_retention = object({
          days  = optional(number)
          mode  = string
          years = optional(number)
        })
      }))
    }))
    replication_configuration = optional(object({
      role = string
      rules = list(object({
        delete_marker_replication_status = optional(string)
        destination = object({
          access_control_translation = optional(object({
            owner = string
          }))
          account_id = optional(string)
          bucket     = string
          metrics = optional(object({
            minutes = optional(number)
            status  = optional(string)
          }))
          replica_kms_key_id = optional(string)
          replication_time = optional(object({
            minutes = optional(number)
            status  = optional(string)
          }))
          storage_class = optional(string)
        })
        filter = optional(object({
          prefix = optional(string)
          tags   = optional(map(string))
        }))
        id       = optional(string)
        prefix   = optional(string)
        priority = optional(number)
        source_selection_criteria = optional(object({
          sse_kms_encrypted_objects = optional(object({
            enabled = bool
          }))
        }))
        status = string
      }))
    }))
    server_side_encryption_configuration = optional(object({
      rule = object({
        apply_server_side_encryption_by_default = object({
          kms_master_key_id = optional(string)
          sse_algorithm     = string
        })
        bucket_key_enabled = optional(bool)
      })
    }))
    versioning = optional(object({
      enabled    = optional(bool)
      mfa_delete = optional(bool)
    }))
    website = optional(object({
      error_document           = optional(string)
      index_document           = optional(string)
      redirect_all_requests_to = optional(string)
      routing_rules            = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.s3_buckets : (
        v.replication_configuration == null || (length(v.replication_configuration.rules) >= 1)
      )
    ])
    error_message = "Each rules list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.s3_buckets : (
        v.lifecycle_rule == null || alltrue([for item in v.lifecycle_rule : (item.expiration == null || (item.expiration.days == null || (item.expiration.days >= 0)))])
      )
    ])
    error_message = "must be at least 0"
  }
  validation {
    condition = alltrue([
      for k, v in var.s3_buckets : (
        v.lifecycle_rule == null || alltrue([for item in v.lifecycle_rule : (item.noncurrent_version_expiration == null || (item.noncurrent_version_expiration.days == null || (item.noncurrent_version_expiration.days >= 1)))])
      )
    ])
    error_message = "must be at least 1"
  }
  validation {
    condition = alltrue([
      for k, v in var.s3_buckets : (
        v.lifecycle_rule == null || alltrue([for item in v.lifecycle_rule : (item.noncurrent_version_transition == null || alltrue([for item in item.noncurrent_version_transition : (item.days == null || (item.days >= 0))]))])
      )
    ])
    error_message = "must be at least 0"
  }
  validation {
    condition = alltrue([
      for k, v in var.s3_buckets : (
        v.lifecycle_rule == null || alltrue([for item in v.lifecycle_rule : (item.transition == null || alltrue([for item in item.transition : (item.days == null || (item.days >= 0))]))])
      )
    ])
    error_message = "must be at least 0"
  }
  validation {
    condition = alltrue([
      for k, v in var.s3_buckets : (
        v.website == null || (v.website.routing_rules == null || (can(jsondecode(v.website.routing_rules))))
      )
    ])
    error_message = "must be valid JSON"
  }
  # Note: 32 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

