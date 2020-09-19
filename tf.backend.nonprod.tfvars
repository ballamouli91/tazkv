
terraform {
  backend "s3" {
      bucket  = "kops-bucket-mouli"
      key     = "aws-azure/terraform.tfstate"
      region  = "ap-southeast-1"
  }
}
