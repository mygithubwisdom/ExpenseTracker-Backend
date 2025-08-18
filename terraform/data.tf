# data "aws_s3_bucket" "noughttrapper_tf_state" {
#   bucket = var.TF_STATE_BUCKET
# }

# data "aws_s3_bucket" "noughttrapper_ci_cd_bucket" {
#   bucket = var.CI_CD_BUCKET
# }
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
