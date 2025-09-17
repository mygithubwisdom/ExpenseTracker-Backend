# =================================================================
#  SIGNIN
# =================================================================
output "LAMBDA_SIGNIN_FUNCTION_ARN" {
  value = aws_lambda_function.signin_function.arn
}
output "LAMBDA_SIGNIN_FUNCTION_NAME" {
  value = aws_lambda_function.signin_function.function_name
}

# =================================================================
#  SIGNUP
# =================================================================
output "LAMBDA_SIGNUP_FUNCTION_ARN" {
  value = aws_lambda_function.signup_function.arn
}
output "LAMBDA_SIGNUP_FUNCTION_NAME" {
  value = aws_lambda_function.signup_function.function_name
}

# =================================================================
#  CONFIRM SIGNUP
# =================================================================
output "LAMBDA_CONFIRM_SIGNUP_FUNCTION_ARN" {
  value = aws_lambda_function.confirm_signup_function.arn
}
output "LAMBDA_CONFIRM_SIGNUP_FUNCTION_NAME" {
  value = aws_lambda_function.confirm_signup_function.function_name
}

# =================================================================
#  LOGIN SIGNUP
# =================================================================
#output "LAMBDA_LOGIN_FUNCTION_ARN" {
 # value = aws_lambda_function.login_function.arn
#}
#output "LAMBDA_LOGIN_FUNCTION_NAME" {
#  value = aws_lambda_function.login_function.function_name
#}

# =================================================================
#  FORGOT_PASSWORD
# =================================================================
output "LAMBDA_FORGOT_PASSWORD_FUNCTION_ARN" {
  value = aws_lambda_function.forgot_password_function.arn
}
output "LAMBDA_FORGOT_PASSWORD_FUNCTION_NAME" {
  value = aws_lambda_function.forgot_password_function.function_name
}

# =================================================================
#  CONFIRM_FORGOT_PASSWORD
# =================================================================
output "LAMBDA_CONFIRM_FORGOT_PASSWORD_FUNCTION_ARN" {
  value = aws_lambda_function.confirm_forgot_password_function.arn
}
output "LAMBDA_CONFIRM_FORGOT_PASSWORD_FUNCTION_NAME" {
  value = aws_lambda_function.confirm_forgot_password_function.function_name
}

# =================================================================
#  CREATE-LINK
# =================================================================
# output "LAMBDA_CREATE_LINK_FUNCTION_ARN" {
#   value = aws_lambda_function.create_link_function.arn
# }
# output "LAMBDA_CREATE_LINK_FUNCTION_NAME" {
#   value = aws_lambda_function.create_link_function.function_name
# }

# =================================================================
#  CONFIRM_FORGOT_PASSWORD
# =================================================================
output "LAMBDA_PUT_CONFIRM_FORGOT_PASSWORD_FUNCTION_ARN" {
  value = aws_lambda_function.put_confirm_forgot_password_function.arn
}
output "LAMBDA_PUT_CONFIRM_FORGOT_PASSWORD_FUNCTION_NAME" {
  value = aws_lambda_function.put_confirm_forgot_password_function.function_name
}


