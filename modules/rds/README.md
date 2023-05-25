# Child Module for RDS Aurora cluster

## Usage
```terraform
module "rds" {
  source = "../modules/rds"

  db_subnet_group_subnet_ids = ["subnet-wordpressl3424", "subnet-ecstask4343"]
  rds_master_password        = "myecstask"
  rds_cluster_engine_version = "<version>"
  kms_key_id                 = "<kms_arn>"
  rds_security_group_ids     = []
}
```

```bash
export AWS_ACCESS_KEY_ID=<write your access key id>
export AWS_SECRET_ACCESS_KEY=<write you secret access key>
export AWS_DEFAULT_REGION=<write default region to create resource in>
```

Then perform the following commands on the root folder:
- `terraform init` terraform initialization
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply infrastructure build
- `terraform destroy` to destroy the infrastructure

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_rds_cluster.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | If an existing DB subnet group exists, provide the name | `string` | `"wordpress-subnet-group"` | no |
| <a name="input_db_subnet_group_subnet_ids"></a> [db\_subnet\_group\_subnet\_ids](#input\_db\_subnet\_group\_subnet\_ids) | Subnets to be used in the db subnet group | `list(string)` | `[]` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS Key ID. | `string` | `null` | no |
| <a name="input_rds_cluster_backup_retention_period"></a> [rds\_cluster\_backup\_retention\_period](#input\_rds\_cluster\_backup\_retention\_period) | Number of days to retain backups | `number` | `1` | no |
| <a name="input_rds_cluster_database_name"></a> [rds\_cluster\_database\_name](#input\_rds\_cluster\_database\_name) | Name of the database to create | `string` | `"wordpress"` | no |
| <a name="input_rds_cluster_deletion_protection"></a> [rds\_cluster\_deletion\_protection](#input\_rds\_cluster\_deletion\_protection) | If the cluster should have deletion protection enabled | `bool` | `false` | no |
| <a name="input_rds_cluster_enable_cloudwatch_logs_export"></a> [rds\_cluster\_enable\_cloudwatch\_logs\_export](#input\_rds\_cluster\_enable\_cloudwatch\_logs\_export) | Set of log types to export to cloudwatch, valid values are audit, error, general, slowquery, postgresql | `list(string)` | <pre>[<br>  "audit"<br>]</pre> | no |
| <a name="input_rds_cluster_engine_version"></a> [rds\_cluster\_engine\_version](#input\_rds\_cluster\_engine\_version) | Engine version to use for the cluster | `string` | `""` | no |
| <a name="input_rds_cluster_identifier"></a> [rds\_cluster\_identifier](#input\_rds\_cluster\_identifier) | Name of the RDS cluster | `string` | `"wordpress"` | no |
| <a name="input_rds_cluster_instance_count"></a> [rds\_cluster\_instance\_count](#input\_rds\_cluster\_instance\_count) | Number of RDS instances to provision | `number` | `2` | no |
| <a name="input_rds_cluster_instance_instance_class"></a> [rds\_cluster\_instance\_instance\_class](#input\_rds\_cluster\_instance\_instance\_class) | Database instance type | `string` | `"db.t3.small"` | no |
| <a name="input_rds_cluster_master_username"></a> [rds\_cluster\_master\_username](#input\_rds\_cluster\_master\_username) | Master username for the RDS cluster | `string` | `"admin"` | no |
| <a name="input_rds_cluster_preferred_backup_window"></a> [rds\_cluster\_preferred\_backup\_window](#input\_rds\_cluster\_preferred\_backup\_window) | The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.  Time in UTC. | `string` | `"08:00-09:00"` | no |
| <a name="input_rds_cluster_preferred_maintenance_window"></a> [rds\_cluster\_preferred\_maintenance\_window](#input\_rds\_cluster\_preferred\_maintenance\_window) | The weekly time range during which system maintenance can occur, in (UTC). | `string` | `"sun:06:00-sun:07:00"` | no |
| <a name="input_rds_cluster_skip_final_snapshot"></a> [rds\_cluster\_skip\_final\_snapshot](#input\_rds\_cluster\_skip\_final\_snapshot) | Determines whether a final DB snapshot is created before the DB cluster is deleted | `bool` | `true` | no |
| <a name="input_rds_master_password"></a> [rds\_master\_password](#input\_rds\_master\_password) | Password for the master DB user. | `string` | `"password"` | no |
| <a name="input_rds_security_group_ids"></a> [rds\_security\_group\_ids](#input\_rds\_security\_group\_ids) | RDS Security Group ID. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to provide to the resources created | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rds_cluster_endpoint"></a> [rds\_cluster\_endpoint](#output\_rds\_cluster\_endpoint) | Endpoint of RDS Aurora Cluster. |
