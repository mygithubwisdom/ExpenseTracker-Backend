# Statefile creation
terraform {
  backend "s3" {
    encrypt = true
    bucket  = "trackam-statefile-backend"
    key     = "dev/terraform.tfstate"
    region  = ""
    # dynamodb_table = "testworklock"
  }
}