variable "region" {
  default = ""
}

variable "ENV" {
  type    = string
  default = "dev"
}

variable "TF_STATE_BUCKET" {
   type    = string
   default = "trackam-statefile-backend"
 }

# variable "CI_CD_BUCKET" {
#   type    = string
#   default = "aws-csean-scanned-bucket"
# }

# variable "m4ace-Terraform-Lock" {
#   type    = string
#   default = "m4ace-Lock-TF"
# }

variable "LAMBDA_PYTHON_VERSION" {
  type    = string
  default = "python3.13"
}

variable "LAMBDA_JAVASCRIPT_VERSION" {
  type    = string
  default = "nodejs18.x"
}

data "aws_caller_identity" "name" {

}

variable "COGNITO_GROUP_LIST" {
  type    = string
  default = "customer"
}

variable "IAM_COGNITO_ASSUMABLE_ROLE_EXTERNAL_ID" {
  default = ""
  type    = string
}

variable "WEBAPP_DNS" {
  default = ""
}
variable "WEBAPP_CERT" {
  type    = string
  default = "JKJs"
}
variable "WEBAPP_CERT_ARN" {
  type    = string
  default = "kjsn"
  }
variable "RESEND_API_KEY" {
  default = ""
  }

variable "MONGODB_URI_1" {
  default = "mongodb+srv://admin"
}

#variable "MONGODB_URI_2" {
 # default = "mongodb+srv://vendlitdb"
#}