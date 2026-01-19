# Lab: Working with Data Blocks

Terraform can query and act on data from cloud infrastructure using data sources. This lab demonstrates how to use data blocks to fetch information from existing resources and export their attributes.

## Tasks

### Task 1: Query Existing Resources Using a Data Block
- Create an S3 bucket in AWS.
- Use a Terraform data block to retrieve information about the bucket:
    ```hcl
    data "aws_s3_bucket" "data_bucket" {
        bucket = "my-data-lookup-bucket-btk"
    }
    ```
- Use the bucket's ARN in an IAM policy resource:
    ```hcl
    resource "aws_iam_policy" "policy" {
        name        = "data_bucket_policy"
        description = "Deny access to my bucket"
        policy = jsonencode({
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Action": [
                        "s3:Get*",
                        "s3:List*"
                    ],
                    "Resource": "${data.aws_s3_bucket.data_bucket.arn}"
                }
            ]
        })
    }
    ```
- Run `terraform plan` and `terraform apply -auto-approve` to deploy.

### Task 2: Export Attributes from a Data Lookup
- Review available attributes in the [Terraform AWS provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket).
- Add output blocks to export bucket information:
    ```hcl
    output "data-bucket-arn" {
        value = data.aws_s3_bucket.data_bucket.arn
    }

    output "data-bucket-domain-name" {
        value = data.aws_s3_bucket.data_bucket.bucket_domain_name
    }

    output "data-bucket-region" {
        value = "The ${data.aws_s3_bucket.data_bucket.id} bucket is located in ${data.aws_s3_bucket.data_bucket.region}"
    }
    ```
- Apply the configuration to view outputs.

