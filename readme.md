# Module - Azure Storage Account (under construction)
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/provider-Azure-blue)](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

Module developed to standardize the creation of Azure Storage Accounts.

## Compatibility Matrix

| Module Version | Terraform Version | AzureRM Version |
|----------------|-------------------| --------------- |
| v1.0.0         | v1.3.8            | 3.45.0          |

## Specifying a version

To avoid that your code get updates automatically, is mandatory to set the version using the `source` option. 
By defining the `?ref=***` in the the URL, you can define the version of the module.

Note: The `?ref=***` refers a tag on the git module repo.

## Use case

```hcl
module "<storage-account-name>" {
  source              = "git::https://github.com/danilomnds/terraform-azurerm-storage-account?ref=v1.0.0"
  name                     = <storage-account-name>
  location                 = <region>
  resource_group_name      = <resource-group-name>
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "LRS"
  tags = {
    "key1"  = "value1"
    "key2"        = "value2"
  }
  containers = { 
    <container-name> = {
      name                  = "<container-name>",
      container_access_type = "<private>"
    }
  }  
}
output "name" {
  value = module.storage-account-name.name
}
output "id" {
  value = module.storage-account-name.id
}
```

## Input variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | storage account name | `string` | n/a | `Yes` |
| resource_group_name | resource group where the ACR will be placed | `string` | n/a | `Yes` |
| location | azure region | `string` | n/a | `Yes` |
| account_kind | defines the kind of account | `string` | `StorageV2` | No |
| account_tier | defines the tier to use for this storage account | `string` | n/a | `Yes` |
| account_replication_type | defines the type of replication to use for this storage account | `string` | n/a | `Yes` |
| cross_tenant_replication_enabled | should cross tenant replication be enabled? | `bool` | `True` | No |
| access_tier | defines the access tier for the storage accounts | `string` | `Hot` | No |
| edge_zone | specifies the edge zone within the azure region where this storage account should exist | `string` | `null` | No |
| enable_https_traffic_only | boolean flag which forces HTTPS if enabled, see here for more information. | `bool` | `True` | No |
| min_tls_version | the minimum supported TLS version for the storage account | `string` | `TLS1_2` | No |
| allow_nested_items_to_be_public | Allow or disallow nested items within this account to opt into being public | `bool` | `True` | No |
| shared_access_key_enabled | indicates whether the storage account permits requests to be authorized with the account access key via shared key | `bool` | `True` | No |
| public_network_access_enabled | whether the public network access is enabled? | `bool` | `True` | No |
| default_to_oauth_authentication | default to Azure Active Directory authorization in the Azure portal when accessing the storage account | `bool` | `False` | No |
| nfsv3_enabled | Is NFSv3 protocol enabled | `bool` | `False` | No |
| custom_domain | block for custom domain configuration | `object({})` | `null` | No |
| customer_managed_key (`to be added`)| block for custom the configuration of custom keys | TBD | TBD | No |
| identity | block for custom the configuration of managed identity  | `object({})` | `null` | No |
| blob_properties | block for custom the configuration of the blobs | `object({})` | `null` | No |
| queue_properties (`to be added`)| block for custom the configuration of queue properties | TBD | TBD | No |
| static_website (`to be added`)| block for custom the configuration of queue static website | TBD | TBD | No |
| share_properties (`to be added`)| block for custom the configuration of queue share properties | TBD | TBD | No |
| network_rules | block for custom the configuration of network rules | `object({})` | `null` | No |
| large_file_share_enabled | Is Large File Share Enabled | `bool` | `null` | No |
| azure_files_authentication (`to be added`)| block for custom the configuration of azure files authentication | TBD | TBD | No |
| routing (`to be added`)| block for custom the configuration of routing | TBD | TBD | No |
| queue_encryption_key_type | The encryption type of the queue service | `string` | `Service` | No |
| table_encryption_key_type | The encryption type of the table service. Possible values are Service and Account | `string` | `Service` | No |
| infrastructure_encryption_enabled | Is infrastructure encryption enabled? Changing this forces a new resource to be created | `bool` | `False` | No |
| immutability_policy (`to be added`)| block for custom the configuration of immutability policy | TBD | TBD | No |
| sas_policy (`to be added`)| block for custom the configuration of sas policy | TBD | TBD | No |
| allowed_copy_scope | Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet | `string` | `null` | No |
| sftp_enabled | Boolean, enable SFTP for the storage account | `bool` | `False` | No |
| tags | tags for the resource | `map(string)` | `{}` | No |
| containers | specifies the list of containers to be created in the storage account | `map(object{})` | `{}` | No |

## Objects and map variables list of acceptable parameters
| Variable Name (Block) | Parameter | Description | Type | Default | Required |
|-----------------------|-----------|-------------|------|---------|:--------:|
| custom_domain | name | The Custom Domain Name to use for the Storage Account, which will be validated by Azure | `string` | `null` | No |
| custom_domain | use_subdomain | Should the Custom Domain Name be validated by using indirect CNAME validation? | `bool` | `null` | No |
| identity | type | pecifies the type of Managed Service Identity that should be configured on this Storage Account | `string` | `null` | No |
| identity | identity_ids | Specifies a list of User Assigned Managed Identity IDs to be assigned to this Storage Account | `liststring()` | `null` | No |
| blob_properties | cors_rule (allowed_headers) | A list of headers that are allowed to be a part of the cross-origin request | `list(string)` | `null` | No |
| blob_properties | cors_rule (allowed_methods) | A list of HTTP methods that are allowed to be executed by the origin | `list(string)` | `null` | No |
| blob_properties | cors_rule (allowed_origins) | A list of origin domains that will be allowed by CORS | `list(string)` | `null` | No |
| blob_properties | cors_rule (exposed_headers) | A list of response headers that are exposed to CORS clients | `list(string)` | `null` | No |
| blob_properties | cors_rule (max_age_in_seconds) | The number of seconds the client should cache a preflight response | `number` | `null` | No |
| blob_properties | delete_retention_policy (days) | Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 7 | `number` | `7` | No |
| blob_properties | restore_policy (days) | Specifies the number of days that the blob can be restored, between 1 and 365 days | `number` | `null` | No |
| blob_properties | versioning_enabled | Is versioning enabled | `bool` | `false` | No |
| blob_properties | change_feed_enabled | Is the blob service properties for change feed events enabled | `bool` | `false` | No |
| blob_properties | change_feed_retention_in_days | The duration of change feed events retention in days | `number` | `0` | No |
| blob_properties | default_service_version | The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version | `string` | `null` | No |
| blob_properties | last_access_time_enabled | Is the last access time based tracking enabled? | `bool` | `false` | No |
| blob_properties | container_delete_retention_policy (days) | Specifies the number of days that the container should be retained, between 1 and 365 days | `number` | `7` | No |
| network_rules | default_action | Specifies the default action of allow or deny when no other rules match | `string` | `Allow` | No |
| network_rules | bypass | Specifies whether traffic is bypassed for Logging/Metrics/AzureServicesh | `list(string)` | `[AzureServices]` | No |
| network_rules | ip_rules |List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed | `list(string)` | `[]` | No |
| network_rules | virtual_network_subnet_ids | A list of resource ids for subnets | `list(string)` | `[]` | No |
| network_rules | private_link_access (endpoint_resource_id) | The resource id of the resource access rule to be granted access | `string` | `null` | No |
| network_rules | private_link_access (endpoint_tenant_id) | The tenant id of the resource of the resource access rule to be granted access | `string` | `null` | No |
| containers | name | container name | `string` | `null` | No |
| containers | container_access_type | blob, private etc | `string` | `null` | No |

## Output variables

| Name | Description |
|------|-------------|
| id | storage account id |
| name | storage account name |

## Documentation
Terraform Azure Storage Account: <br>
[https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)