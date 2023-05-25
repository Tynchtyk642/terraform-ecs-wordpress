# **Child Module for Elastic Container Service**
## This module will create
- _ECS Cluster_
- _ECS Task Definition_
- _ECS Service_

## Usage
```terraform
module "alb" {
  source = "../modules/alb"

  vpc_id                = module.vpc.vpc_id
  lb_security_group_ids = local.lb_security_group_ids
  lb_subnet_ids         = module.vpc.public_subnets
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
| [aws_lb.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.wordpress_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.wordpress_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.wordpress_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_lb_internal"></a> [lb\_internal](#input\_lb\_internal) | If the load balancer should be an internal load balancer | `bool` | `false` | no |
| <a name="input_lb_listener_certificate_arn"></a> [lb\_listener\_certificate\_arn](#input\_lb\_listener\_certificate\_arn) | The ACM certificate ARN to use on the HTTPS listener | `string` | `""` | no |
| <a name="input_lb_listener_enable_ssl"></a> [lb\_listener\_enable\_ssl](#input\_lb\_listener\_enable\_ssl) | Enable the SSL listener, if this is set the lb\_listener\_certificate\_arn must also be provided | `bool` | `false` | no |
| <a name="input_lb_listener_ssl_policy"></a> [lb\_listener\_ssl\_policy](#input\_lb\_listener\_ssl\_policy) | The SSL policy to apply to the HTTPS listener | `string` | `"ELBSecurityPolicy-FS-1-2-Res-2019-08"` | no |
| <a name="input_lb_name"></a> [lb\_name](#input\_lb\_name) | Name for the load balancer | `string` | `"wordpress"` | no |
| <a name="input_lb_security_group_ids"></a> [lb\_security\_group\_ids](#input\_lb\_security\_group\_ids) | Security groups to assign to the load balancer | `list(string)` | `[]` | no |
| <a name="input_lb_subnet_ids"></a> [lb\_subnet\_ids](#input\_lb\_subnet\_ids) | Subnets where load balancer should be created | `list(string)` | n/a | yes |
| <a name="input_lb_target_group_http"></a> [lb\_target\_group\_http](#input\_lb\_target\_group\_http) | Name of the HTTP target group | `string` | `"wordpress-http"` | no |
| <a name="input_lb_target_group_https"></a> [lb\_target\_group\_https](#input\_lb\_target\_group\_https) | Name of the HTTPS target group | `string` | `"wordpress-https"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to provide to the resources created | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID to create resource in. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_dns_name"></a> [lb\_dns\_name](#output\_lb\_dns\_name) | n/a |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | n/a |
