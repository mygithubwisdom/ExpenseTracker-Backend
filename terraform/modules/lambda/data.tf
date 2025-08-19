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
  source_dir  = "${path.module}/codes/confirm-signup"
  output_path = "${path.module}/codes/zip/confirm-signup.zip"
}

#data "archive_file" "lambda_login_archive" {
 # type        = "zip"
  #source_dir  = "${path.module}/codes/login"
  #output_path = "${path.module}/codes/zip/login.zip"
#}

data "archive_file" "lambda_forget_password_archive" {
  type        = "zip"
  source_dir  = "${path.module}/codes/forget_password"
  output_path = "${path.module}/codes/zip/forget_password.zip"
}

data "archive_file" "lambda_confirm_forgot_password_archive" {
  type        = "zip"
  source_dir  = "${path.module}/codes/confirm_forgot_password"
  output_path = "${path.module}/codes/zip/confirm_forgot_password.zip"
}