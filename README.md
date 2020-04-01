## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| local | n/a |
| random | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| subnet | The subnet to start the instance in | `string` | n/a | yes |
| instance\_ami | The AMI to use to launch the Synclounge instance | `string` | `""` | no |
| instance\_spot | Use a spot instance instead of an on-demand one | `bool` | `true` | no |
| instance\_spot\_block\_duration | The block duration to request for the spot instance | `number` | `0` | no |
| instance\_spot\_price | The maximum spot price to accept when creating a spot instance | `string` | `""` | no |
| instance\_type | The instance type to use launch the Synclounge instance | `string` | `"t3.small"` | no |
| private\_key\_file | Whether to output a private key file for use by ssh | `bool` | `false` | no |
| sl\_password | The Synclounge room password for auto-join | `string` | `""` | no |
| sl\_room | The Synclounge room to auto-join | `string` | `""` | no |
| ssh\_whitelist | CIDR blocks to be allowed to access the SSH port of the instance | `list(string)` | `[]` | no |
| web\_accessurl | The URL used to reach this Synclounge server | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | A randomly generated UUID to identify this module run from others |
| private\_key | The unique private key for the launched instance |
| public\_ip | The public IP of the launched instance |

