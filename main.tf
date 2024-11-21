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
  https_traffic_only_enabled       = var.https_traffic_only_enabled
  min_tls_version                  = var.min_tls_version
  allow_nested_items_to_be_public  = var.allow_nested_items_to_be_public
  shared_access_key_enabled        = var.shared_access_key_enabled
  public_network_access_enabled    = var.public_network_access_enabled
  default_to_oauth_authentication  = var.default_to_oauth_authentication
  is_hns_enabled                   = var.is_hns_enabled
  nfsv3_enabled                    = var.nfsv3_enabled
  dynamic "custom_domain" {
    for_each = var.custom_domain != null ? [var.custom_domain] : []
    content {
      name          = lookup(custom_domain.value, "name", null)
      use_subdomain = lookup(custom_domain.value, "use_subdomain", false)
    }
  }
  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key != null ? [var.customer_managed_key] : []
    content {
      key_vault_key_id          = lookup(customer_managed_key.value, "key_vault_key_id", null)
      managed_hsm_key_id        = lookup(customer_managed_key.value, "managed_hsm_key_id", null)
      user_assigned_identity_id = customer_managed_key.value.user_assigned_identity_id
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
        for_each = blob_properties.value.cors_rule != null ? [blob_properties.value.cors_rule] : []
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
      dynamic "delete_retention_policy" {
        for_each = blob_properties.value.delete_retention_policy != null ? [blob_properties.value.delete_retention_policy] : []
        content {
          days                     = delete_retention_policy.value.days
          permanent_delete_enabled = lookup(delete_retention_policy.value, "permanent_delete_enabled", null)
        }
      }
      dynamic "restore_policy" {
        for_each = blob_properties.value.restore_policy != null ? [blob_properties.value.restore_policy] : []
        content {
          days = restore_policy.value.days
        }
      }
      versioning_enabled            = lookup(blob_properties.value, "versioning_enabled", null)
      change_feed_enabled           = lookup(blob_properties.value, "change_feed_enabled", null)
      change_feed_retention_in_days = lookup(blob_properties.value, "change_feed_retention_in_days", null)
      default_service_version       = lookup(blob_properties.value, "default_service_version", null)
      last_access_time_enabled      = lookup(blob_properties.value, "last_access_time_enabled", null)
      dynamic "container_delete_retention_policy" {
        for_each = blob_properties.value.container_delete_retention_policy != null ? [blob_properties.value.container_delete_retention_policy] : []
        content {
          days = container_delete_retention_policy.value.days
        }
      }
    }
  }
  dynamic "queue_properties" {
    for_each = var.queue_properties != null ? [var.queue_properties] : []
    content {
      dynamic "cors_rule" {
        for_each = queue_properties.value.cors_rule != null ? [queue_properties.value.cors_rule] : []
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
      dynamic "logging" {
        for_each = queue_properties.value.logging != null ? [queue_properties.value.logging] : []
        content {
          delete                = logging.value.delete
          read                  = logging.value.read
          version               = logging.value.version
          write                 = logging.value.write
          retention_policy_days = lookup(logging.value, "retention_policy_days", null)
        }
      }
      dynamic "minute_metrics" {
        for_each = queue_properties.value.minute_metrics != null ? [queue_properties.value.minute_metrics] : []
        content {
          enabled               = minute_metrics.value.enabled
          version               = minute_metrics.value.version
          include_apis          = lookup(minute_metrics.value, "include_apis", null)
          retention_policy_days = lookup(minute_metrics.value, "retention_policy_days", null)
        }
      }
      dynamic "hour_metrics" {
        for_each = queue_properties.value.hour_metrics != null ? [queue_properties.value.hour_metrics] : []
        content {
          enabled               = hour_metrics.value.enabled
          version               = hour_metrics.value.version
          include_apis          = lookup(hour_metrics.value, "include_apis", null)
          retention_policy_days = lookup(hour_metrics.value, "retention_policy_days", null)
        }
      }
    }
  }
  dynamic "static_website" {
    for_each = var.static_website != null ? [var.static_website] : []
    content {
      index_document     = static_website.value.index_document
      error_404_document = static_website.value.error_404_document
    }
  }
  dynamic "share_properties" {
    for_each = var.share_properties != null ? [var.share_properties] : []
    content {
      dynamic "cors_rule" {
        for_each = share_properties.value.cors_rule != null ? [share_properties.value.cors_rule] : []
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
      dynamic "retention_policy" {
        for_each = share_properties.value.retention_policy != null ? [share_properties.value.retention_policy] : []
        content {
          days = retention_policy.value.days
        }
      }
      dynamic "smb" {
        for_each = share_properties.value.smb != null ? [share_properties.value.smb] : []
        content {
          versions                        = lookup(smb.value, "versions", null)
          authentication_types            = lookup(smb.value, "authentication_types", null)
          kerberos_ticket_encryption_type = lookup(smb.value, "kerberos_ticket_encryption_type", null)
          channel_encryption_type         = lookup(smb.value, "versions", null)
          multichannel_enabled            = lookup(smb.value, "multichannel_enabled", null)
        }
      }
    }
  }
  dynamic "network_rules" {
    for_each = var.network_rules != null ? [var.network_rules] : []
    content {
      default_action             = lookup(network_rules.value, "default_action", "Allow")
      bypass                     = lookup(network_rules.value, "bypass", null)
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnet_ids
      dynamic "private_link_access" {
        for_each = network_rules.value.private_link_access != null ? [network_rules.value.private_link_access] : []
        content {
          endpoint_resource_id = private_link_access.value.endpoint_resource_id
          endpoint_tenant_id   = lookup(private_link_access.value, "endpoint_tenant_id", null)
        }
      }
    }
  }
  large_file_share_enabled = var.large_file_share_enabled
  dynamic "azure_files_authentication" {
    for_each = var.azure_files_authentication != null ? [var.azure_files_authentication] : []
    content {
      directory_type = lookup(azure_files_authentication.value, "directory_type", null)
      dynamic "active_directory" {
        for_each = azure_files_authentication.value.active_directory != null ? [azure_files_authentication.value.active_directory] : []
        content {

          domain_name         = active_directory.value.domain_name
          domain_guid         = active_directory.value.domain_guid
          domain_sid          = lookup(active_directory.value, "domain_sid", null)
          storage_sid         = lookup(active_directory.value, "storage_sid", null)
          forest_name         = lookup(active_directory.value, "forest_name", null)
          netbios_domain_name = lookup(active_directory.value, "netbios_domain_name", null)
        }
      }
      default_share_level_permission = lookup(azure_files_authentication.value, "default_share_level_permission", null)
    }
  }
  dynamic "routing" {
    for_each = var.routing != null ? [var.routing] : []
    content {
      publish_internet_endpoints  = lookup(routing.value, "publish_internet_endpoints", false)
      publish_microsoft_endpoints = lookup(routing.value, "publish_microsoft_endpoints", false)
      choice                      = lookup(routing.value, "choice", "MicrosoftRouting")
    }
  }
  queue_encryption_key_type = var.queue_encryption_key_type
  table_encryption_key_type = var.table_encryption_key_type

  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  dynamic "immutability_policy" {
    for_each = var.immutability_policy != null ? [var.immutability_policy] : []
    content {
      allow_protected_append_writes = immutability_policy.value.allow_protected_append_writes
      state                         = immutability_policy.value.state
      period_since_creation_in_days = immutability_policy.value.period_since_creation_in_days
    }
  }
  dynamic "sas_policy" {
    for_each = var.sas_policy != null ? [var.sas_policy] : []
    content {
      expiration_period = sas_policy.value.expiration_period
      expiration_action = lookup(sas_policy.value, "expiration_action", "Log")
    }
  }
  allowed_copy_scope = var.allowed_copy_scope
  sftp_enabled       = var.sftp_enabled
  dns_endpoint_type  = var.dns_endpoint_type
  tags               = local.tags
  lifecycle {
    ignore_changes = [
      tags["create_date"]
    ]
  }
}

# creates containers (blobs)
resource "azurerm_storage_container" "ctr" {
  depends_on                        = [azurerm_storage_account.sta]
  for_each                          = var.containers != null ? { for k, v in var.containers : k => v if v != null } : {}
  storage_account_id                = azurerm_storage_account.sta.id
  name                              = lookup(each.value, "name", null)
  container_access_type             = lookup(each.value, "container_access_type", "private")
  default_encryption_scope          = lookup(each.value, "default_encryption_scope", null)
  encryption_scope_override_enabled = lookup(each.value, "encryption_scope_override_enabled", null)
  metadata                          = lookup(each.value, "metadata", null)
}

# creates file shares
resource "azurerm_storage_share" "fileshare" {
  depends_on         = [azurerm_storage_account.sta]
  for_each           = var.fileshare != null ? { for k, v in var.fileshare : k => v if v != null } : {}
  storage_account_id = azurerm_storage_account.sta.id
  name               = each.value.name
  access_tier        = lookup(each.value, "access_tier", null)
  dynamic "acl" {
    for_each = each.value.acl != null ? [each.value.acl] : []
    content {
      id = acl.value.Id
      dynamic "access_policy" {
        for_each = acl.value.access_policy != null ? [acl.value.access_policy] : []
        content {
          permissions = access_policy.value.permissions
          start       = lookup(access_policy.value, "start", null)
          expiry      = lookup(access_policy.value, "expiry", null)
        }
      }
    }
  }
  enabled_protocol = lookup(each.value, "enabled_protocol", "SMB")
  quota            = each.value.quota
  metadata         = each.value.metadata
}

# grantees access on static web site blob for an Azure AD group
resource "azurerm_role_assignment" "static_web" {
  depends_on = [azurerm_storage_account.sta]
  for_each = {
    for k, v in toset(var.azure_ad_groups) : k => v
    if var.static_website != null
  }
  scope                = "${azurerm_storage_account.sta.id}/blobServices/default/containers/$web"
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = each.value
}

# grantees read access and token generator on the storage account level for an Azure AD group
resource "azurerm_role_assignment" "static_web_reader_data_access_custom" {
  depends_on = [azurerm_storage_account.sta]
  for_each = {
    for k, v in toset(var.azure_ad_groups) : k => v
    if var.static_website != null || var.containers != null
  }
  scope                = azurerm_storage_account.sta.id
  role_definition_name = "Reader and Data Access Custom"
  principal_id         = each.value
}

# grantees access on blobs for an Azure AD group
resource "azurerm_role_assignment" "ctr" {
  depends_on           = [azurerm_storage_container.ctr]
  for_each             = (var.containers != null && var.containers_rbac == true) ? { for k, v in var.containers : k => v if v != null } : {}
  scope                = "${azurerm_storage_account.sta.id}/blobServices/default/containers/${lookup(each.value, "name", null)}"
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = lookup(each.value, "ad_group", null)
}