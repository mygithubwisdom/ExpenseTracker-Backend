variable "CURRENT_ACCOUNT_ID" {}
variable "ENV" {}
variable "BASE_PATH" {
  default = "core"
}

variable "LAMBDA_NAMES" {
  description = "contains Names of lambda(s) to be added into <aws_lambda_permission> resource"
  type        = list(string)
}
variable "RESOURCES_PREFIX" {}
variable "API_DOMAIN_NAME" {

}
variable "LAMBDA_CREATE_LINK_FUNCTION_ARN" {}
