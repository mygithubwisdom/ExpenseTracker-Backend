locals {
  LAMBDA_VERSION = "v1"
  layers = ["${aws_lambda_layer_version.javascript_layer.arn}", "${aws_lambda_layer_version.mongoose_layer.arn}"]

}

################################################################################
# Layer
################################################################################


resource "aws_lambda_layer_version" "javascript_layer" {
  filename                 = "${path.module}/layers/javascript_layer.zip"
  layer_name               = "${var.RESOURCES_PREFIX}-javascript-layer"
  compatible_runtimes      = [var.LAMBDA_JAVASCRIPT_VERSION]
  compatible_architectures = ["x86_64", "arm64"]
  description              = "javascript layer for node lambdas"
}
resource "aws_lambda_layer_version" "mongoose_layer" {
  filename                 = "${path.module}/layers/mongoose-layer.zip"
  layer_name               = "${var.RESOURCES_PREFIX}-mongoose-layer"
  compatible_runtimes      = [var.LAMBDA_JAVASCRIPT_VERSION]
  compatible_architectures = ["x86_64", "arm64"]
  description              = "Moongoose layer for node lambdas"
}

################################################################################
# Lambda
################################################################################

# resource "aws_lambda_function" "lambda_messaging_templates" {
#   filename         = "${path.module}/codes/zip/messaging_templates.zip"
#   function_name    = "${var.RESOURCES_PREFIX}-messaging-templates"
#   role             = var.LAMBDA_MESSAGING_TEMPLATES_ROLE_ARN
#   handler          = "messaging_templates.lambda_handler"
#   source_code_hash = data.archive_file.lambda_messaging_templates_archive.output_base64sha256
#   runtime          = var.LAMBDA_PYTHON_VERSION
#   timeout          = 300
#   environment {
#     variables = {
#       ENV                   = "${var.ENV}"
#       MESSAGING_BUCKET_NAME = "${var.MESSAGING_BUCKET_NAME}"
#       INFO_EMAIL            = "${var.INFO_EMAIL}"
#       USER_TABLE_NAME       = "${var.USER_TABLE_NAME}"
#       CURRENT_AWS_REGION    = "${var.AWS_REGION}"
#     }
#   }
#   layers = ["${aws_lambda_layer_version.lambda_utils_layer.arn}", "${aws_lambda_layer_version.python_layer.arn}", "${aws_lambda_layer_version.default_layer.arn}"]
# }

/*
 OOO   PPPP   EEEEE  N   N
O   O  P   P  E      NN  N
O   O  PPPP   EEEE   N N N
O   O  P      E      N  NN
 OOO   P      EEEEE  N   N
*/


/*
  ____    ___   ____   _____ 
 / ___|  / _ \ |  _ \ | ____|
| |     | | | || |_) ||  _|  
| |___  | |_| ||  _ < | |___ 
 \____|  \___/ |_| \_\|_____|
*/

# =================================================================
# Create a Lambda function for signin
# =========================================================================
resource "aws_lambda_function" "signin_function" {
  filename         = "${path.module}/codes/zip/signin.zip"
  function_name    = "${var.RESOURCES_PREFIX}-signin-${local.LAMBDA_VERSION}"
  role             = var.SIGNIN_FUNCTION_ROLE_ARN
  handler          = "signin.lambda_handler"
  source_code_hash = data.archive_file.lambda_signin_archive.output_base64sha256
  runtime          = var.LAMBDA_JAVASCRIPT_VERSION
  timeout          = 180
  memory_size      = 1024

  environment {
    variables = {
      ENV         = "${var.ENV}"
      POOL_ID = var.POOL_ID
      CLIENT_ID = var.CLIENT_ID
      CLIENT_SECRET = var.CLIENT_SECRET
      MONGODB_URI = var.MONGODB_URI_1

    }
  }
  layers = local.layers
}


# =================================================================
# Create a Lambda function for signup
# =========================================================================
resource "aws_lambda_function" "signup_function" {
  filename         = "${path.module}/codes/zip/signup.zip"
  function_name    = "${var.RESOURCES_PREFIX}-signup-${local.LAMBDA_VERSION}"
  role             = var.SIGNUP_FUNCTION_ROLE_ARN
  handler          = "signup.lambda_handler"
  source_code_hash = data.archive_file.lambda_signup_archive.output_base64sha256
  runtime          = var.LAMBDA_JAVASCRIPT_VERSION
  timeout          = 180
  memory_size      = 1024

  environment {
    variables = {
      ENV         = "${var.ENV}"
      POOL_ID = var.POOL_ID
      CLIENT_ID = var.CLIENT_ID
      CLIENT_SECRET = var.CLIENT_SECRET
      MONGODB_URI = var.MONGODB_URI_1

    }
  }
  layers = local.layers
}


# =================================================================
# Create a Lambda function for confirm signup
# =========================================================================
resource "aws_lambda_function" "confirm_signup_function" {
  filename         = "${path.module}/codes/zip/confirm_signup.zip"
  function_name    = "${var.RESOURCES_PREFIX}-confirm_signup-${local.LAMBDA_VERSION}"
  role             = var.CONFIRM_SIGNUP_FUNCTION_ROLE_ARN
  handler          = "confirm_signup.lambda_handler"
  source_code_hash = data.archive_file.lambda_confirm_signup_archive.output_base64sha256
  runtime          = var.LAMBDA_JAVASCRIPT_VERSION
  timeout          = 180
  memory_size      = 1024

  environment {
    variables = {
      ENV         = "${var.ENV}"
      POOL_ID = var.POOL_ID
      CLIENT_ID = var.CLIENT_ID
      CLIENT_SECRET = var.CLIENT_SECRET
      MONGODB_URI = var.MONGODB_URI_1
    }
  }
  layers = local.layers
}


# =================================================================
# Create a Lambda function for login
# =========================================================================
#resource "aws_lambda_function" "login_function" {
 # filename         = "${path.module}/codes/zip/login.zip"
 # function_name    = "${var.RESOURCES_PREFIX}-login-${local.LAMBDA_VERSION}"
 # role             = var.LOGIN_FUNCTION_ROLE_ARN
 # handler          = "login.lambda_handler"
 # source_code_hash = data.archive_file.lambda_login_archive.output_base64sha256
 # runtime          = var.LAMBDA_JAVASCRIPT_VERSION
 # timeout          = 180
 # memory_size      = 1024

#  environment {
#    variables = {
#      ENV         = "${var.ENV}"
#      POOL_ID = var.POOL_ID
#      CLIENT_ID = var.CLIENT_ID
#      CLIENT_SECRET = var.CLIENT_SECRET
#      # MONGODB_URI = var.MONGODB_URI
#    }
#  }
#  layers = local.layers
#}


# =================================================================
# Create a Lambda function for forgot_password
# =========================================================================

resource "aws_lambda_function" "forgot_password_function" {
  filename         = "${path.module}/codes/zip/forgot_password.zip"
  function_name    = "${var.RESOURCES_PREFIX}-forgot_password-${local.LAMBDA_VERSION}"
  role             = var.FORGOT_PASSWORD_FUNCTION_ROLE_ARN
  handler          = "forgot_password.lambda_handler"
  source_code_hash = data.archive_file.lambda_forgot_password_archive.output_base64sha256
  runtime          = var.LAMBDA_JAVASCRIPT_VERSION
  timeout          = 180
  memory_size      = 1024

  environment {
    variables = {
      ENV         = "${var.ENV}"
      POOL_ID = var.POOL_ID
      CLIENT_ID = var.CLIENT_ID
      CLIENT_SECRET = var.CLIENT_SECRET
      MONGODB_URI = var.MONGODB_URI_1

    }
  }
  layers = local.layers
}


# =================================================================
# Create a Lambda function for confirm_forgot_password
# =========================================================================

resource "aws_lambda_function" "confirm_forgot_password_function" {
  filename         = "${path.module}/codes/zip/confirm-forgot-password.zip"
  function_name    = "${var.RESOURCES_PREFIX}-confirm-forgot-password-${local.LAMBDA_VERSION}"
  role             = var.CONFIRM_FORGOT_PASSWORD_FUNCTION_ROLE_ARN
  handler          = "confirm-forgot-password.lambda_handler"
  source_code_hash = data.archive_file.lambda_confirm_forgot_password_archive.output_base64sha256
  runtime          = var.LAMBDA_JAVASCRIPT_VERSION
  timeout          = 180
  memory_size      = 1024

  environment {
    variables = {
      ENV         = "${var.ENV}"
      POOL_ID = var.POOL_ID
      CLIENT_ID = var.CLIENT_ID
      CLIENT_SECRET = var.CLIENT_SECRET
      MONGODB_URI = var.MONGODB_URI_1

    }
  }
  layers = local.layers
}

# # =================================================================
# # Create a Lambda function for CREATE-LINK
# # =========================================================================

# resource "aws_lambda_function" "create_link_function" {
#   filename         = "${path.module}/codes/zip/create-link.zip"
#   function_name    = "${var.RESOURCES_PREFIX}-create-link-${local.LAMBDA_VERSION}"
#   role             = var.CREATE_LINK_FUNCTION_ROLE_ARN
#   handler          = "create-link.lambda_handler"
#   source_code_hash = data.archive_file.lambda_create_link_archive.output_base64sha256
#   runtime          = var.LAMBDA_JAVASCRIPT_VERSION
#   timeout          = 180
#   memory_size      = 1024

#   environment {
#     variables = {
#       ENV         = "${var.ENV}"
#       POOL_ID = var.POOL_ID
#       CLIENT_ID = var.CLIENT_ID
#       CLIENT_SECRET = var.CLIENT_SECRET
#       #MONGODB_URI = var.MONGODB_URI_1

#     }
#   }
#   layers = local.layers
# }