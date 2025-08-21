data "archive_file" "lambda_signin_archive" {
  type        = "zip"
  source_dir  = "${path.module}/codes/signin"
  output_path = "${path.module}/codes/zip/signin.zip"
}

data "archive_file" "lambda_signup_archive" {
  type        = "zip"
  source_dir  = "${path.module}/codes/signup"
  output_path = "${path.module}/codes/zip/signup.zip"
}

data "archive_file" "lambda_confirm_signup_archive" {
  type        = "zip"
  source_dir  = "${path.module}/codes/confirm_signup"
  output_path = "${path.module}/codes/zip/confirm_signup.zip"
}

#data "archive_file" "lambda_login_archive" {
 # type        = "zip"
  #source_dir  = "${path.module}/codes/login"
  #output_path = "${path.module}/codes/zip/login.zip"
#}

data "archive_file" "lambda_forgot_password_archive" {
  type        = "zip"
  source_dir  = "${path.module}/codes/forgot_password"
  output_path = "${path.module}/codes/zip/forgot_password.zip"
}

data "archive_file" "lambda_confirm_forgot_password_archive" {
  type        = "zip"
  source_dir  = "${path.module}/codes/confirm-forgot-password"
  output_path = "${path.module}/codes/zip/confirm-forgot-password.zip"
}

# data "archive_file" "lambda_create_link_archive" {
#   type        = "zip"
#   source_dir  = "${path.module}/codes/create_link"
#   output_path = "${path.module}/codes/zip/create_link.zip"
# }

