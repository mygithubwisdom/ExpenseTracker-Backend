variable "ENV" {}
variable "AWS_REGION" {}
variable "LAMBDA_PYTHON_VERSION" {}
variable "LAMBDA_JAVASCRIPT_VERSION" {}
variable "RESOURCES_PREFIX" {}
#variable "USER_TABLE_NAME" {
  
#}
variable "MONGODB_URI_1" {
  default = "mongodb+srv://nomsowisdom3286:Mv3OQYjoCznSo0j5@cluster0.kjk8cyq.mongodb.net/?retryWrites=true&w=majority&appName=Cluster01"
}

#variable "MONGODB_URI_2" {
 # default = "put your uri here"
#}
variable "CLIENT_SECRET" {}
variable "CLIENT_ID" {}
variable "POOL_ID" {}
variable "SIGN_IN_FUNCTION_ROLE_ARN" {}
variable "SIGN_UP_FUNCTION_ROLE_ARN" {}
variable "CONFIRM_SIGN_UP_FUNCTION_ROLE_ARN" {}
#variable "LOGIN_FUNCTION_ROLE_ARN" {}
variable "FORGET_PASSWORD_FUNCTION_ROLE_ARN" {}
variable "CONFIRM_FORGOT_PASSWORD_FUNCTION_ROLE_ARN" {}