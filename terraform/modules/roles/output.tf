# =================================================================
#  SIGNIN  ROLE
# =================================================================
output "SIGN_IN_FUNCTION_ROLE_ARN" {
  value = aws_iam_role.sign_in_function_role.arn
}
output "SIGN_IN_FUNCTION_ROLE_NAME" {
  value = aws_iam_role.sign_in_function_role.name
}

# =================================================================
#  SIGNUP  ROLE
# =================================================================
output "SIGN_UP_FUNCTION_ROLE_ARN" {
  value = aws_iam_role.sign_up_function_role.arn
}
output "SIGN_UP_FUNCTION_ROLE_NAME" {
  value = aws_iam_role.sign_up_function_role.name
}

# =================================================================
#  CONFIRM SIGNUP  ROLE
# =================================================================
output "CONFIRM_SIGN_UP_FUNCTION_ROLE_ARN" {
  value = aws_iam_role.confirm_sign_up_function_role.arn
}
output "CONFIRM_SIGN_UP_FUNCTION_ROLE_NAME" {
  value = aws_iam_role.confirm_sign_up_function_role.name
}


# =================================================================
#  LOGIN  ROLE
# =================================================================
#output "LOGIN_FUNCTION_ROLE_ARN" {
 # value = aws_iam_role.login_function_role.arn
#}
#output "LOGIN_FUNCTION_ROLE_NAME" {
 # value = aws_iam_role.login_function_role.name
#}

# =================================================================
#  FORGOT PASSWORD
# =================================================================
output "FORGET_PASSWORD_FUNCTION_ROLE_ARN" {
  value = aws_iam_role.forget_password_function_role.arn
}
output "FORGET_PASSWORD_FUNCTION_ROLE_NAME" {
  value = aws_iam_role.forget_password_function_role.name
}

# =================================================================
#  CONFIRM FORGOT PASSWORD
# =================================================================
output "CONFIRM_FORGOT_PASSWORD_FUNCTION_ROLE_ARN" {
  value = aws_iam_role.confirm_forgot_password_function_role.arn
}
output "CONFIRM_FORGOT_PASSWORD_FUNCTION_ROLE_NAME" {
  value = aws_iam_role.confirm_forgot_password_function_role.name
}

# =================================================================
# CREATE LINK
# =================================================================
output "CREATE_LINK_FUNCTION_ROLE_ARN" {
  value = aws_iam_role.create_link_function_role.arn
}
output "CONFIRM_CREATE_LINK_FUNCTION_ROLE_NAME" {
  value = aws_iam_role.create_link_function_role.name
}