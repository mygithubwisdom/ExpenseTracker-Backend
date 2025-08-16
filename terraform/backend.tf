# Statefile creation
terraform {
  backend "s3" {
    encrypt = true
    bucket  = "trackam-statefile-backend"
    key     = "dev/terraform.tfstate"
    region  = "us-east-1"
    # dynamodb_table = "testworklock"
  }
}