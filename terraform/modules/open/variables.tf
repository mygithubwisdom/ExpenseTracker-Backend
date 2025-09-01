variable "CURRENT_ACCOUNT_ID" {}
variable "ENV" {}
variable "BASE_PATH" {
  default = "open"
}

variable "LAMBDA_NAMES" {
  description = "contains Names of lambda(s) to be added into <aws_lambda_permission> resource"
  type        = list(string)
}
variable "RESOURCES_PREFIX" {}
variable "API_DOMAIN_NAME" {

}


variable "LAMBDA_SIGNIN_FUNCTION_ARN" {}

variable "LAMBDA_SIGNUP_FUNCTION_ARN" {}
variable "LAMBDA_CONFIRM_SIGNUP_FUNCTION_ARN" {
  
}



variable "LAMBDA_FORGOT_PASSWORD_FUNCTION_ARN" {}

variable "LAMBDA_CONFIRM_FORGOT_PASSWORD_FUNCTION_ARN" {}
variable "LAMBDA_PUT_CONFIRM_FORGOT_PASSWORD_FUNCTION_ARN" {}
