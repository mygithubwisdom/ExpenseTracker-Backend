# =================================================================
#  SIGNIN
# =================================================================
output "LAMBDA_SIGN_IN_FUNCTION_ARN" {
  value = aws_lambda_function.sign_in_function.arn
}
output "LAMBDA_SIGN_IN_FUNCTION_NAME" {
  value = aws_lambda_function.sign_in_function.function_name
}

# =================================================================
#  SIGNUP
# =================================================================
output "LAMBDA_SIGN_UP_FUNCTION_ARN" {
  value = aws_lambda_function.sign_up_function.arn
}
output "LAMBDA_SIGN_UP_FUNCTION_NAME" {
  value = aws_lambda_function.sign_up_function.function_name
}

# =================================================================
#  CONFIRM SIGNUP
# =================================================================
output "LAMBDA_CONFIRM_SIGN_UP_FUNCTION_ARN" {
  value = aws_lambda_function.confirm_signup_function.arn
}
output "LAMBDA_CONFIRM_SIGN_UP_FUNCTION_NAME" {
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
#  FORGET_PASSWORD
# =================================================================
output "LAMBDA_FORGET_PASSWORD_FUNCTION_ARN" {
  value = aws_lambda_function.forget_password_function.arn
}
output "LAMBDA_FORGET_PASSWORD_FUNCTION_NAME" {
  value = aws_lambda_function.forget_password_function.function_name
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

