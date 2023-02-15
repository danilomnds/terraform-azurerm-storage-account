# Module - Azure Storage Account
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/provider-Azure-blue)](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

Module developed to standardize the creation of Azure Storage Accounts.

## Compatibility Matrix

| Module Version | Terraform Version | AzureRM Version |
|----------------|-------------------| --------------- |
| v1.0.0         | v1.3.8            | 3.43.0          |

## Specifying a version

To avoid that your code get updates automatically, is mandatory to set the version using the `source` option. 
By defining the `?ref=***` in the the URL, you can define the version of the module.

Note: The `?ref=***` refers a tag on the git module repo.

## Use case

```hcl
```

## Input variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | storage account name | `string` | n/a | `Yes` |
| location | azure region | `string` | n/a | `Yes` |
| resource_group_name | resource group where the ACR will be placed | `string` | n/a | `Yes` |
| tags | tags for the resource | `map(string)` | `{}` | No |

## Output variables

| Name | Description |
|------|-------------|
| id | storage account id |
| name | storage account name |

## Documentation
Terraform Azure Storage Account: <br>
[https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)