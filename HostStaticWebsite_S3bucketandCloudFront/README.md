# HostStaticWebsite_S3bucketandCloudFront
`HostStaticWebsite_S3bucketandCloudFront`
This repository contains Terraform configurations to set up an AWS S3 bucket for hosting a static website and a corresponding CloudFront distribution for content delivery.

# Files Included:
`terraformcloufront.tf`: Terraform configuration file for setting up the CloudFront distribution.

`terraforms3bucket.tf`: Terraform configuration file for creating the S3 bucket.

`s3_bucket_policy.json`: JSON file containing the S3 bucket policy for permissions.

`Jenkinsfile`: Jenkins pipeline configuration for automating Terraform deployment.

# Description:
This project aims to automate the deployment of a static website on AWS using Terraform. 

It sets up an S3 bucket to host the website content and a CloudFront distribution for fast content delivery and caching.

# Terraform Configurations:
`terraformcloufront.tf`: Defines the CloudFront distribution settings including origin, caching behavior, SSL configuration, etc.

`terraforms3bucket.tf`: Specifies the S3 bucket configuration, including versioning, encryption, CORS rules, and tags.

# Usage:
Ensure you have Terraform installed.
Configure AWS credentials with the necessary permissions.

Adjust variables or settings in the Terraform files as needed.

Execute Terraform commands (`terraform init`, `terraform plan`, `terraform apply`) to provision AWS resources.

Optionally, set up a CI/CD pipeline in Jenkins using Jenkinsfile for automated deployments.
  
# Important Note:
Ensure that you have reviewed and understood the changes that Terraform will make to your AWS infrastructure before applying them.

