# Module - Azure Storage Account
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/provider-Azure-blue)](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

Module developed to standardize the creation of Azure Storage Accounts and containers. 
With this module you can apply rbac on containers (Storage Blob Data Contributor) referring Azure AD Groups. 
This module can create the rbac for the container used by static web sites ($web) referring Azure AD Groups. 

## Compatibility Matrix

| Module Version | Terraform Version | AzureRM Version |
|----------------|-------------------| --------------- |
| v1.0.0         | v1.6.6            | 3.86.0          |
| v2.0.0         | v1.9.8            | 4.9.0           |

## Specifying a version

To avoid that your code get updates automatically, is mandatory to set the version using the `source` option. 
By defining the `?ref=***` in the the URL, you can define the version of the module.

Note: The `?ref=***` refers a tag on the git module repo.

## Use case for blobs

```hcl
module "<storage-account-name>" {
  source                   = "git::https://github.com/danilomnds/terraform-azurerm-storage-account?ref=v2.0.0"
  name                     = <storage-account-name>
  location                 = <region>
  resource_group_name      = <resource-group-name>
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "LRS"
  azure_ad_groups = ["group id 1"]
  tags = {
    "key1" = "value1"
    "key2" = "value2"
  }
  containers = [
    { 
      name                  = "<container-1>",
      container_access_type = "<private>"
      ad_group              = "<azure group ad>" 
    },
    { 
      name                  = "<container-2>",
      container_access_type = "<private>"
      ad_group              = "<azure group ad>" 
    },
  ]
  containers_rbac = true
}
output "name" {
  value = module.storage-account-name.name
}
output "id" {
  value = module.storage-account-name.id
}
```

## Use case for file shares
```hcl
module "<storage-account-name>" {
  source                   = "git::https://github.com/danilomnds/terraform-azurerm-storage-account?ref=v2.0.0"
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
  fileshare = [
    { 
      name = "<fsappl01>",
      quota = "10"      
    },
    { 
      name = "<fsappl02>",
      quota = "20"      
    }
  ] 
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
| location | azure region | `string` | n/a | `Yes` |
| resource_group_name | resource group where the resources will be created | `string` | n/a | `Yes` |
| account_kind | defines the kind of account | `string` | `StorageV2` | No |
| account_tier | defines the tier to use for this storage account | `string` | n/a | `Yes` |
| account_replication_type | defines the type of replication to use for this storage account | `string` | n/a | `Yes` |
| cross_tenant_replication_enabled | should cross tenant replication be enabled? | `bool` | `True` | No |
| access_tier | defines the access tier for the storage accounts | `string` | `Hot` | No |
| edge_zone | specifies the edge zone within the azure region where this storage account should exist | `string` | `null` | No |
| https_traffic_only_enabled | boolean flag which forces HTTPS if enabled, see here for more information. | `bool` | `True` | No |
| min_tls_version | the minimum supported TLS version for the storage account | `string` | `TLS1_2` | No |
| allow_nested_items_to_be_public | Allow or disallow nested items within this account to opt into being public | `bool` | `false` | No |
| shared_access_key_enabled | indicates whether the storage account permits requests to be authorized with the account access key via shared key | `bool` | `True` | No |
| public_network_access_enabled | whether the public network access is enabled? | `bool` | `True` | No |
| default_to_oauth_authentication | default to Azure Active Directory authorization in the Azure portal when accessing the storage account | `bool` | `False` | No |
| is_hns_enabled | Is Hierarchical Namespace enabled | `bool` | `False` | No |
| nfsv3_enabled | Is NFSv3 protocol enabled | `bool` | `False` | No |
| custom_domain | block for custom domain configuration | `object({})` | `null` | No |
| customer_managed_key | block for custom the configuration of custom keys | `object({})` | `null` | No |
| identity | block for custom the configuration of managed identity  | `object({})` | `null` | No |
| blob_properties | block for custom the configuration of the blobs | `object({})` | `null` | No |
| queue_properties | block for custom the configuration of queue properties | `object({})` | `null` | No |
| static_website | block for custom the configuration of queue static website | `object({})` | `null` | No |
| share_properties | block for custom the configuration of queue share properties | `object({})` | `null` | No |
| network_rules | block for custom the configuration of network rules | `object({})` | `null` | No |
| large_file_share_enabled | Is Large File Share Enabled | `bool` | `null` | No |
| azure_files_authentication | block for custom the configuration of azure files authentication | `object({})` | `null` | No |
| routing | block for custom the configuration of routing | `object({})` | `null` | No |
| queue_encryption_key_type | The encryption type of the queue service | `string` | `Service` | No |
| table_encryption_key_type | The encryption type of the table service. Possible values are Service and Account | `string` | `Service` | No |
| infrastructure_encryption_enabled | Is infrastructure encryption enabled? Changing this forces a new resource to be created | `bool` | `False` | No |
| immutability_policy | block for custom the configuration of immutability policy | `object({})` | `null` | No |
| sas_policy | block for custom the configuration of sas policy | `object({})` | `null` | No |
| allowed_copy_scope | Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet | `string` | `null` | No |
| sftp_enabled | Boolean, enable SFTP for the storage account | `bool` | `False` | No |
| dns_endpoint_type | Specifies which DNS endpoint type to use | `string` | `Standard` | No |
| tags | tags for the resource | `map(string)` | `{}` | No |
| azure_ad_groups | list of azure AD groups that will have access to the resources | `list` | `[]` | No |
| containers | specifies the list of containers to be created in the storage account | `map(object{})` | `{}` | No |
| containers_rbac | specifies if the rbac should be applied for the container. Documentation [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | `bool` | `false` | No |
| fileshare | specifies the list of file shares to be created in the storage account. Documentation [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | `map(object{})` | `{}` | No |

## Objects and map variables list of acceptable parameters

For blocks please check the documentation [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)
## Output variables

| Name | Description |
|------|-------------|
| id | storage account id |
| name | storage account name |

## Documentation
Terraform Azure Storage Account: <br>
[https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)

Terraform Azure Blobs: <br>
[https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container)

Terraform Azure File Share: <br>
[https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share)