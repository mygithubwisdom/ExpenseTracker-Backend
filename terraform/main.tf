locals {
  RESOURCES_PREFIX = "${lower(var.ENV)}-trackam"
  ACCOUNTID        = data.aws_caller_identity.current.account_id
  INFO_EMAIL       = "contacttrackam25@gmail.com"
  TRACKAM_EMAIL    = "contacttrackam25@gmail.com"

  DOMAIN_NAME = "api.${var.WEBAPP_DNS}"
  # cognito_domain_name        = lower(var.ENV) == "prod" ? "auth.${var.WEBAPP_DNS}" : "auth.${var.WEBAPP_DNS}"
  cognito_domain_name = var.WEBAPP_DNS
  common_tags = {
    environment = var.ENV
    project     = "TrackAm"
    managedby   = "cloud@email.com"
  }
}


module "roles" {
  source           = "./modules/roles"
  ENV              = var.ENV
  AWS_REGION       = var.region
  RESOURCES_PREFIX = local.RESOURCES_PREFIX
  
}


# POLICY

module "policy" {
  source                                     = "./modules/policy"
  ENV                                        = var.ENV
  AWS_REGION                                 = var.region
  RESOURCES_PREFIX                           = local.RESOURCES_PREFIX
  CURRENT_ACCOUNT_ID                         = data.aws_caller_identity.current.account_id
  SIGNIN_FUNCTION_ROLE_NAME                  = module.roles.SIGNIN_FUNCTION_ROLE_NAME
  SIGNUP_FUNCTION_ROLE_NAME                  = module.roles.SIGNUP_FUNCTION_ROLE_NAME
  CONFIRM_SIGNUP_FUNCTION_ROLE_NAME          = module.roles.CONFIRM_SIGNUP_FUNCTION_ROLE_NAME
#  LOGIN_FUNCTION_ROLE_NAME                   = module.roles.LOGIN_FUNCTION_ROLE_NAME
  FORGOT_PASSWORD_FUNCTION_ROLE_NAME         = module.roles.FORGOT_PASSWORD_FUNCTION_ROLE_NAME
  CONFIRM_FORGOT_PASSWORD_FUNCTION_ROLE_NAME = module.roles.CONFIRM_FORGOT_PASSWORD_FUNCTION_ROLE_NAME
#  CREATE_LINK_FUNCTION_ROLE_NAME             = module.roles.CREATE_LINK_FUNCTION_ROLE_NAME
PUT_CONFIRM_FORGOT_PASSWORD_FUNCTION_ROLE_NAME = module.roles.PUT_CONFIRM_FORGOT_PASSWORD_FUNCTION_ROLE_NAME
}

module "cognito_end_user" {
  source                                 = "./modules/cognito"
  ENV                                    = var.ENV
  COMMON_TAGS                            = local.common_tags
  EMAIL_SENDER                           = local.INFO_EMAIL
  IAM_COGNITO_ASSUMABLE_ROLE_EXTERNAL_ID = var.IAM_COGNITO_ASSUMABLE_ROLE_EXTERNAL_ID
  AWS_REGION                             = data.aws_region.current.name
  CURRENT_ACCOUNT_ID                     = local.ACCOUNTID
  WEBAPP_DNS                             = var.WEBAPP_DNS
  COGNITO_GROUP_LIST                     = var.COGNITO_GROUP_LIST
  RESOURCE_PREFIX                        = local.RESOURCES_PREFIX
  BUCKET_NAME                            = "bucket" #module.s3.MESSAGING_BUCKET_NAME
  RESOURCE                               = "end_user"
  PYTHON_LAMBDA_VERSION                  = var.LAMBDA_PYTHON_VERSION
  COGNITO_DOMAIN_NAME                    = local.cognito_domain_name
  RESEND_API_KEY                         = var.RESEND_API_KEY
 # USER_TABLE_NAME                        = module.user_table.table_name
  MONGODB_URI_1                          = var.MONGODB_URI_1
 # MONGODB_URI_2                          = var.MONGODB_URI_2
}

# Lambda
module "lambda" {
  source                                 = "./modules/lambda"
  ENV                                    = var.ENV
  AWS_REGION                             = var.region
  RESOURCES_PREFIX                       = local.RESOURCES_PREFIX
  CLIENT_ID                              = module.cognito_end_user.COGNITO_USER_CLIENT_ID_A
  POOL_ID                                = module.cognito_end_user.COGNITO_USER_POOL_ID
  CLIENT_SECRET                          = module.cognito_end_user.COGNITO_USER_CLIENT_SECRET_A
  LAMBDA_JAVASCRIPT_VERSION              = var.LAMBDA_JAVASCRIPT_VERSION
  LAMBDA_PYTHON_VERSION                  = var.LAMBDA_PYTHON_VERSION
  SIGNIN_FUNCTION_ROLE_ARN               = module.roles.SIGNIN_FUNCTION_ROLE_ARN
  SIGNUP_FUNCTION_ROLE_ARN               = module.roles.SIGNUP_FUNCTION_ROLE_ARN
  CONFIRM_SIGNUP_FUNCTION_ROLE_ARN       = module.roles.CONFIRM_SIGNUP_FUNCTION_ROLE_ARN
  # LOGIN_FUNCTION_ROLE_ARN               = module.roles.LOGIN_FUNCTION_ROLE_ARN
  FORGOT_PASSWORD_FUNCTION_ROLE_ARN      = module.roles.FORGOT_PASSWORD_FUNCTION_ROLE_ARN
  CONFIRM_FORGOT_PASSWORD_FUNCTION_ROLE_ARN = module.roles.CONFIRM_FORGOT_PASSWORD_FUNCTION_ROLE_ARN
  PUT_CONFIRM_FORGOT_PASSWORD_FUNCTION_ROLE_ARN = module.roles.PUT_CONFIRM_FORGOT_PASSWORD_FUNCTION_ROLE_ARN
  # CREATE_LINK_FUNCTION_ROLE_ARN         = module.roles.CREATE_LINK_FUNCTION_ROLE_ARN
  MONGODB_URI_1                          = var.MONGODB_URI_1
  # MONGODB_URI_2                         = var.MONGODB_URI_2
}


# DYNAMODB TABLE .....
#module "user_table" {
 # source           = "./modules/dynamodb/user_table"
  #ENV              = var.ENV
  #AWS_REGION       = var.region
  #RESOURCES_PREFIX = local.RESOURCES_PREFIX
  #table_name       = "user_table"
#}
#module "product_table" {
#  source           = "./modules/dynamodb/product_table"
#  ENV              = var.ENV
#  AWS_REGION       = var.region
#  RESOURCES_PREFIX = local.RESOURCES_PREFIX
#  table_name       = "product_table"
#}

#  module "core" {
#    source                                            = "./modules/core"
#    ENV                                               = var.ENV
#    RESOURCES_PREFIX                                  = local.RESOURCES_PREFIX
#    CURRENT_ACCOUNT_ID                                = data.aws_caller_identity.current.account_id
#    API_DOMAIN_NAME                                   = local.DOMAIN_NAME
#   #  LAMBDA_CREATE_LINK_FUNCTION_ARN                   = module.lambda.LAMBDA_CREATE_LINK_FUNCTION_ARN
 
#    LAMBDA_NAMES = [
#     # module.lambda.LAMBDA_CREATE_LINK_FUNCTION_NAME,
#    ] 
#  }

module "open" {
  source                                      = "./modules/open"
  ENV                                         = var.ENV
  RESOURCES_PREFIX                            = local.RESOURCES_PREFIX
  CURRENT_ACCOUNT_ID                          = data.aws_caller_identity.current.account_id
  API_DOMAIN_NAME                             = local.DOMAIN_NAME
  LAMBDA_SIGNIN_FUNCTION_ARN                  = module.lambda.LAMBDA_SIGNIN_FUNCTION_ARN
  LAMBDA_SIGNUP_FUNCTION_ARN                  = module.lambda.LAMBDA_SIGNUP_FUNCTION_ARN
  LAMBDA_CONFIRM_SIGNUP_FUNCTION_ARN          = module.lambda.LAMBDA_CONFIRM_SIGNUP_FUNCTION_ARN
  # LAMBDA_LOGIN_FUNCTION_ARN                  = module.lambda.LAMBDA_LOGIN_FUNCTION_ARN
  LAMBDA_FORGOT_PASSWORD_FUNCTION_ARN         = module.lambda.LAMBDA_FORGOT_PASSWORD_FUNCTION_ARN
  LAMBDA_CONFIRM_FORGOT_PASSWORD_FUNCTION_ARN = module.lambda.LAMBDA_CONFIRM_FORGOT_PASSWORD_FUNCTION_ARN
  LAMBDA_PUT_CONFIRM_FORGOT_PASSWORD_FUNCTION_ARN = module.lambda.LAMBDA_PUT_CONFIRM_FORGOT_PASSWORD_FUNCTION_ARN  

  LAMBDA_NAMES = [
    module.lambda.LAMBDA_SIGNIN_FUNCTION_NAME,
    module.lambda.LAMBDA_SIGNUP_FUNCTION_NAME,
    module.lambda.LAMBDA_CONFIRM_SIGNUP_FUNCTION_NAME,
    # module.lambda.LAMBDA_LOGIN_FUNCTION_NAME,
    module.lambda.LAMBDA_FORGOT_PASSWORD_FUNCTION_NAME,
    module.lambda.LAMBDA_CONFIRM_FORGOT_PASSWORD_FUNCTION_NAME,
    module.lambda.LAMBDA_PUT_CONFIRM_FORGOT_PASSWORD_FUNCTION_NAME,
  ]
}



 module "s3" {
   source           = "./modules/s3"
   RESOURCES_PREFIX = local.RESOURCES_PREFIX
 }

# arn:aws:s3:::trackam-template
##==================================================
#  SES creation....................
##==================================================

 module "ses" {
   source     = "./modules/ses"
   TRACKAM_EMAIL = local.TRACKAM_EMAIL
   INFO_EMAIL    = local.INFO_EMAIL
 }






