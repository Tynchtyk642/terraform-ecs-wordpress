# **Child Module for Elastic Container Service**
## This module will create
- _ECS Cluster_
- _ECS Task Definition_
- _ECS Service_

## Usage
```terraform
module "ecs" {
  source = "../modules/ecs"

  container_definitions = templatefile(
    "${path.module}/container_definitions/wordpress.tpl",
    {
      ecs_service_container_name = "wordpress"
      wordpress_db_host          = module.rds.rds_cluster_endpoint
      wordpress_db_user          = "admin"
      wordpress_db_name          = "wordpress"
      aws_region                 = data.aws_region.current.name
      aws_logs_group             = aws_cloudwatch_log_group.wordpress.name
      aws_account_id             = data.aws_caller_identity.current.account_id
      secret_name                = "<secret_manager_name>"
      cloudwatch_log_group       = "wordpress-log-group"
    }
  )
  target_group_arn       = "<lb_target_group_arn>"
  secret_arn             = "<secret_manager_arn>"
  ecs_service_subnet_ids = ["subnet-wordpressl3424", "subnet-ecstask4343"]
  kms_key_arn            = "<kms_key_arn>"
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
| [aws_ecs_cluster.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_efs_access_point.wordpress_plugins](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_access_point) | resource |
| [aws_efs_access_point.wordpress_themes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_access_point) | resource |
| [aws_efs_file_system.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_iam_policy.ecs_task_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ecs_task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecs_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.ecs_task_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_task_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | ECS Task container definitions. | `string` | n/a | yes |
| <a name="input_ecs_cloudwatch_logs_group_name"></a> [ecs\_cloudwatch\_logs\_group\_name](#input\_ecs\_cloudwatch\_logs\_group\_name) | Name of the Log Group where ECS logs should be written | `string` | `"/ecs/wordpress"` | no |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | Name for the ECS cluster | `string` | `"wordpress_cluster"` | no |
| <a name="input_ecs_service_assign_public_ip"></a> [ecs\_service\_assign\_public\_ip](#input\_ecs\_service\_assign\_public\_ip) | Whether to assign a public IP to the task ENIs | `bool` | `false` | no |
| <a name="input_ecs_service_container_name"></a> [ecs\_service\_container\_name](#input\_ecs\_service\_container\_name) | Container name for the container definition and Target Group association | `string` | `"wordpress"` | no |
| <a name="input_ecs_service_desired_count"></a> [ecs\_service\_desired\_count](#input\_ecs\_service\_desired\_count) | Number of tasks to have running | `number` | `2` | no |
| <a name="input_ecs_service_name"></a> [ecs\_service\_name](#input\_ecs\_service\_name) | Name for the ECS Service | `string` | `"wordpress"` | no |
| <a name="input_ecs_service_security_group_ids"></a> [ecs\_service\_security\_group\_ids](#input\_ecs\_service\_security\_group\_ids) | Security groups assigned to the task ENIs | `list(string)` | `[]` | no |
| <a name="input_ecs_service_subnet_ids"></a> [ecs\_service\_subnet\_ids](#input\_ecs\_service\_subnet\_ids) | Subnet ids where ENIs are created for tasks | `list(string)` | n/a | yes |
| <a name="input_ecs_task_definition_cpu"></a> [ecs\_task\_definition\_cpu](#input\_ecs\_task\_definition\_cpu) | Number of CPU units reserved for the container in powers of 2 | `string` | `"1024"` | no |
| <a name="input_ecs_task_definition_family"></a> [ecs\_task\_definition\_family](#input\_ecs\_task\_definition\_family) | Specify a family for a task definition, which allows you to track multiple versions of the same task definition | `string` | `"wordpress-family"` | no |
| <a name="input_ecs_task_definition_memory"></a> [ecs\_task\_definition\_memory](#input\_ecs\_task\_definition\_memory) | Specify a family for a task definition, which allows you to track multiple versions of the same task definition | `string` | `"2048"` | no |
| <a name="input_efs_service_security_group_ids"></a> [efs\_service\_security\_group\_ids](#input\_efs\_service\_security\_group\_ids) | Security groups to assign to the EFS mount target | `list(string)` | `[]` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | KMS Key ARN. | `string` | `null` | no |
| <a name="input_secret_arn"></a> [secret\_arn](#input\_secret\_arn) | Secret Manager Secret arn | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to provide to the resources created | `map(string)` | `{}` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | ARN of the Load Balancer target group to associate with the service. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#output\_ecs\_cluster\_arn) | n/a |
| <a name="output_ecs_service_id"></a> [ecs\_service\_id](#output\_ecs\_service\_id) | n/a |
| <a name="output_ecs_task_definition_arn"></a> [ecs\_task\_definition\_arn](#output\_ecs\_task\_definition\_arn) | n/a |
| <a name="output_ecs_task_definition_family"></a> [ecs\_task\_definition\_family](#output\_ecs\_task\_definition\_family) | n/a |
| <a name="output_ecs_task_definition_revision"></a> [ecs\_task\_definition\_revision](#output\_ecs\_task\_definition\_revision) | n/a |
