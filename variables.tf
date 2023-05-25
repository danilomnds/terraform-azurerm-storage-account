variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "account_kind" {
  type    = string
  default = "StorageV2"
}

variable "account_tier" {
  type = string
}

variable "account_replication_type" {
  type = string
}

variable "cross_tenant_replication_enabled" {
  type    = bool
  default = true
}

variable "access_tier" {
  type    = string
  default = "Hot"
}

variable "edge_zone" {
  type    = string
  default = null
}

variable "enable_https_traffic_only" {
  type    = bool
  default = true
}

variable "min_tls_version" {
  type    = string
  default = "TLS1_2"
}

variable "allow_nested_items_to_be_public" {
  type    = bool
  default = false
}

variable "shared_access_key_enabled" {
  type    = bool
  default = true
}

variable "public_network_access_enabled" {
  type    = bool
  default = true
}

variable "default_to_oauth_authentication" {
  type    = bool
  default = false
}

variable "is_hns_enabled" {
  type    = bool
  default = false
}

variable "nfsv3_enabled" {
  type    = bool
  default = false
}

variable "custom_domain" {
  type = object({
    name          = string
    use_subdomain = optional(bool)
  })
  default = null
}

/* will be added latter
variable "customer_managed_key" {  
}
*/

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "blob_properties" {
  type = object({
    cors_rule = optional(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    }))
    delete_retention_policy           = optional(object({ days = number }))
    restore_policy                    = optional(object({ days = number }))
    versioning_enabled                = optional(bool)
    change_feed_enabled               = optional(bool)
    change_feed_retention_in_days     = optional(number)
    default_service_version           = optional(string)
    use_subdomain                     = optional(bool)
    last_access_time_enabled          = optional(bool)
    container_delete_retention_policy = optional(object({ days = number }))
  })
  default = null
}

/* will be added latter
variable "queue_properties" {  
}
*/

variable "static_website" {
  type = object({
    index_document     = optional(string)
    error_404_document = optional(string)
  })
  default = null
}

/*
variable "share_properties" {  
}
*/

variable "network_rules" {
  type = object({
    # check the default
    # default_action = string
    bypass              = list(string)
    ip_rules            = list(string)
    subnet_ids          = list(string)
    private_link_access = optional(list(object({ endpoint_resource_id = string, endpoint_tenant_id = string })))
  })
  default = null
}

variable "large_file_share_enabled" {
  type    = bool
  default = null
}

/* will be added latter
variable "azure_files_authentication" {  
}

variable "routing" {  
}
*/
variable "queue_encryption_key_type" {
  type    = string
  default = "Service"
}

variable "table_encryption_key_type" {
  type    = string
  default = "Service"
}

variable "infrastructure_encryption_enabled" {
  type    = bool
  default = false
}

/* will be added latter
variable "immutability_policy" {  
}

variable "sas_policy" {
}
*/

variable "allowed_copy_scope" {
  type    = string
  default = null
}

variable "sftp_enabled" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "containers" {
  description = "You can use this var to specify the list of containers to be created"
  type = map(object({
    name                  = string
    container_access_type = string
    ad_group              = string
  }))
  default = null
}

variable "azure_ad_groups" {
  type    = list(string)
  default = []
}

variable "containers_rbac" {
 type = bool
 default = false
}