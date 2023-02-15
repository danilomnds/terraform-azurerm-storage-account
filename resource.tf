resource "azurerm_storage_account" "sta" {
  name                             = var.name
  resource_group_name              = var.resource_group_name
  location                         = var.location
  account_kind                     = var.account_kind
  account_tier                     = var.account_tier
  account_replication_type         = var.account_replication_type
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled
  access_tier                      = var.access_tier
  edge_zone                        = var.edge_zone
  enable_https_traffic_only        = var.enable_https_traffic_only
  min_tls_version                  = var.min_tls_version
  allow_nested_items_to_be_public  = var.allow_nested_items_to_be_public
  shared_access_key_enabled        = var.shared_access_key_enabled
  public_network_access_enabled    = var.public_network_access_enabled
  default_to_oauth_authentication  = var.default_to_oauth_authentication
  #is_hns_enabled = var.is_hns_enabled  
  nfsv3_enabled = var.nfsv3_enabled
  dynamic "custom_domain" {
    for_each = var.custom_domain != null ? [var.custom_domain] : []
    content {
      days    = lookup(custom_domain.value, "name", null)
      enabled = lookup(custom_domain.value, "use_subdomain", false)
    }
  }
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
  dynamic "blob_properties" {
    for_each = var.blob_properties != null ? [var.blob_properties] : []
    content { 
      dynamic "cors_rule" {
        for_each = blob_properties.value.cors_rule
        content {                    
          allowed_headers = cors_rule.value.allowed_headers
          allowed_methods = cors_rule.value.allowed_methods
          allowed_origins = cors_rule.value.allowed_origins
          exposed_headers = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
      dynamic "delete_retention_policy" {
        for_each = blob_properties.value.delete_retention_policy
        content {                    
          days = delete_retention_policy.value.days
        }
      }
      dynamic "restore_policy" {
        for_each = blob_properties.value.restore_policy
        content {                    
          days = restore_policy.value.days
        }
      }
      versioning_enabled = lookup(blob_properties.value, "versioning_enabled", null)
      change_feed_enabled = lookup(blob_properties.value, "change_feed_enabled", null)
      change_feed_retention_in_days = lookup(blob_properties.value, "change_feed_retention_in_days", null)
      default_service_version = lookup(blob_properties.value, "default_service_version", null)
      use_subdomain = lookup(blob_properties.value, "use_subdomain", null)
      last_access_time_enabled = lookup(blob_properties.value, "last_access_time_enabled", null)
      dynamic "container_delete_retention_policy" {
        for_each = blob_properties.value.container_delete_retention_policy
        content {                    
          days = container_delete_retention_policy.value.days
        }
      }
    }    
  }
  dynamic "network_rules" {
    for_each = var.network_rules != null ? [var.network_rules] : []
    content { 
      #default_action = lookup(network_rule_set.value, "default_action", "Allow")
      bypass = lookup(network_rules.value, "bypass", null)
      ip_rules = network_rules.value.ip_rules
      virtual_network_subnet_ids  = network_rules.value.virtual_network_subnet_ids
      dynamic "private_link_access" {
        for_each = network_rules.value.private_link_access
        content {
          endpoint_resource_id = private_link_access.value.endpoint_resource_id
          endpoint_tenant_id = private_link_access.value.endpoint_tenant_id
        }        
      }
    }    
  } 
  # large_file_share_enabled          = var.large_file_share_enabled
  queue_encryption_key_type         = var.queue_encryption_key_type
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  allowed_copy_scope                = var.allowed_copy_scope
  sftp_enabled                      = var.sftp_enabled
  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags["create_date"]
    ]
  }
}