variable "ENV" {}
variable "COMMON_TAGS" {}
variable "AWS_REGION" {}
variable "CURRENT_ACCOUNT_ID" {}
variable "IAM_COGNITO_ASSUMABLE_ROLE_EXTERNAL_ID" {
  description = "External ID for Cognito SMS role trust relationship"
  type        = string
  default     = "cognito-sms-external"
}
variable "EMAIL_SENDER" {}
variable "COGNITO_GROUP_LIST" {}
variable "WEBAPP_DNS" {}
variable "RESOURCE_PREFIX" {}
variable "PYTHON_LAMBDA_VERSION" {}
variable "BUCKET_NAME" {}
variable "RESOURCE" {}
variable "COGNITO_DOMAIN_NAME" {}
variable "COGNITO_SMS_POLICY_ARN"{
  description = "ARN of the Cognito SMS policy"
  type        = string
    default     = "arn:aws:iam::aws:policy/service-role/AmazonSNSRole"
}
variable "RESEND_API_KEY" {

}
#variable "USER_TABLE_NAME" {

#}

variable "MONGODB_URI_1" {
  description = "Primary MongoDB connection string"
  type        = string
  sensitive   = true
  default = "MONGO_DB_URL=mongodb+srv://admin:"
}

#variable "MONGODB_URI_2" {
#  description = "Secondary MongoDB connection string"
#  type        = string
#  sensitive   = true
#}