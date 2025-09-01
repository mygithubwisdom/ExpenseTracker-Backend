resource "aws_iam_policy" "trackam_lambda_policy" {
  name        = "trackam_lambda_policy"
  path        = "/"
  description = "trackam_lambda_policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Action" : [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:UpdateItem",
          "dynamodb:GetRecords",
          "dynamodb:Scan",
          "dynamodb:BatchWriteItem"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:aws:dynamodb:*:${var.CURRENT_ACCOUNT_ID}:table/*"
      },
      {
        "Action" : [
          "execute-api:Invoke",
          "execute-api:ManageConnections",
          "apigateway:*"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:aws:execute-api:*:${var.CURRENT_ACCOUNT_ID}:*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:listLogGroup",
          "logs:listLogStream",
          "logs:PutLogEvents",
          "logs:GetLogEvents",
          "logs:CreateLogStream",
          "logs:CreateLogGroup",
          "logs:FilterLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ],
        "Resource" : [
          "arn:aws:logs:*:${var.CURRENT_ACCOUNT_ID}:*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "lambda:InvokeFunction",
          "lambda:InvokeFunctionUrl"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "cognito-identity:Describe*",
          "cognito-identity:Get*",
          "cognito-identity:List*",
          "cognito-idp:Describe*",
          "cognito-idp:AdminGet*",
          "cognito-idp:AdminList*",
          "cognito-idp:List*",
          "cognito-idp:Get*",

          "cognito-idp:AdminCreateUser*",
          "cognito-sync:Describe*",
          "cognito-sync:*",
          "cognito-sync:Get*",
          "cognito-sync:List*",
          "cognito-idp:AdminUpdateUserAttributes",
          "cognito-idp:UpdateUserAttributes",
          "cognito-idp:*",
          "iam:ListOpenIdConnectProviders",
          "iam:ListRoles",
          "sns:ListPlatformApplications",
          "ec2:*"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:listNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface",
          "ec2:AssignPrivateIpAddresses",
          "ec2:UnassignPrivateIpAddresses"
        ],
        "Resource" : "*"
      },

      {
        "Effect" : "Allow",
        "Action" : [
          "ses:*"
        ],
        "Resource" : ["*" ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListObjects"
        ],
        "Resource" : "*"
      }

    ]
  })
}


# ROLE POLICY ATTACHMENT
resource "aws_iam_role_policy_attachment" "lambda_sign_in_function_attachment" {
  role       = var.SIGNIN_FUNCTION_ROLE_NAME
  policy_arn = aws_iam_policy.trackam_lambda_policy.arn
}
resource "aws_iam_role_policy_attachment" "lambda_sign_up_function_attachment" {
  role       = var.SIGNUP_FUNCTION_ROLE_NAME
  policy_arn = aws_iam_policy.trackam_lambda_policy.arn
}
resource "aws_iam_role_policy_attachment" "lambda_confirm_signup_function_attachment" {
  role       = var.CONFIRM_SIGNUP_FUNCTION_ROLE_NAME
  policy_arn = aws_iam_policy.trackam_lambda_policy.arn
}



resource "aws_iam_role_policy_attachment" "lambda_forgot_password_function_attachment" {
  role       = var.FORGOT_PASSWORD_FUNCTION_ROLE_NAME
  policy_arn = aws_iam_policy.trackam_lambda_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_confirm-forgot-password_function_attachment" {
  role       = var.CONFIRM_FORGOT_PASSWORD_FUNCTION_ROLE_NAME
  policy_arn = aws_iam_policy.trackam_lambda_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_PUT-confirm-forgot-password_function_attachment" {
  role       = var.PUT_CONFIRM_FORGOT_PASSWORD_FUNCTION_ROLE_NAME
  policy_arn = aws_iam_policy.trackam_lambda_policy.arn
}

# resource "aws_iam_role_policy_attachment" "lambda_create_link_function_attachment" {
#   role       = var.CREATE_LINK_FUNCTION_ROLE_NAME
#   policy_arn = aws_iam_policy.trackam_lambda_policy.arn
# }

data "aws_iam_policy_document" "cognito_sms" {
  statement {
    actions   = ["sns:Publish"]
    resources = ["*"] # or restrict to specific SNS topics if you have them
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "cognito_sms" {
  name        = "Cognito-SMS-Policy"
  description = "Policy to allow Cognito to send SMS via SNS"
  policy      = data.aws_iam_policy_document.cognito_sms.json
}

resource "aws_iam_role" "cognito_sms_role" {
  name = "CognitoSMSRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cognito-idp.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "cognito_sms_policy" {
  name        = "CognitoSMSPolicy"
  description = "Policy allowing Cognito to send SMS via SNS"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["sns:Publish"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cognito_sms_role_attach" {
  role       = aws_iam_role.cognito_sms_role.name
  policy_arn = aws_iam_policy.cognito_sms_policy.arn
}
