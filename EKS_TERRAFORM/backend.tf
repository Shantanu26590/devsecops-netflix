terraform {
  backend "s3" {
    bucket = "vishakha-netflix-0409" # Replace with your actual S3 bucket name
    key    = "EKS/terraform.tfstate"
    region = "us-east-1"
  }
}
