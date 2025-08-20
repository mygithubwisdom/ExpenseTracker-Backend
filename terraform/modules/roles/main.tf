# =================================================================
#  SIGNIN ROLE
# =================================================================
resource "aws_iam_role" "signin_function_role" {
  name = "SIGNIN_FUNCTION_${var.RESOURCES_PREFIX}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# =================================================================
#  SIGNUP ROLE
# =================================================================
resource "aws_iam_role" "signup_function_role" {
  name = "SIGNUP_FUNCTION_${var.RESOURCES_PREFIX}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# =================================================================
#  CONFIRM SIGNUP ROLE
# =================================================================
resource "aws_iam_role" "confirm_signup_function_role" {
  name = "CONFIRM_SIGNUP_FUNCTION_${var.RESOURCES_PREFIX}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}


# =================================================================
#  LOGIN ROLE
# =================================================================
#resource "aws_iam_role" "login_function_role" {
 # name = "LOGIN_FUNCTION_${var.RESOURCES_PREFIX}"

  #assume_role_policy = jsonencode({
  #  Version = "2012-10-17"
   # Statement = [
   #   {
    #    Effect = "Allow"
     #   Principal = {
      #    Service = "lambda.amazonaws.com"
       # }
       # Action = "sts:AssumeRole"
     # }
   # ]
  #})
#}


# =================================================================
#  FORGOT PASSWORD ROLE
# =================================================================
resource "aws_iam_role" "forgot_password_function_role" {
  name = "FORGOT_PASSWORD_FUNCTION_${var.RESOURCES_PREFIX}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}


# =================================================================
#  CONFIRM FORGOT PASSWORD ROLE
# =================================================================
resource "aws_iam_role" "confirm_forgot_password_function_role" {
  name = "CONFIRM_FORGOT-PASSWORD-FUNCTION_${var.RESOURCES_PREFIX}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# # =================================================================
# #  CREATE LINK ROLE
# # =================================================================
# resource "aws_iam_role" "create_link_function_role" {
#   name = "CREATE_LINK_FUNCTION_${var.RESOURCES_PREFIX}"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

