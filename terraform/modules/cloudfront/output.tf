#output "cloudfront_distribution_id" {
#  value = aws_cloudfront_distribution.s3_trackam_domain.id
#}

#output "cloudfront_url" {
#  description = "CloudFront Distribution URL"
#  value       = "https://${aws_cloudfront_distribution.s3_trackam_domain.domain_name}"
#}

#output "cloudfront_distribution_arn" {
#  value = aws_cloudfront_distribution.s3_trackam_domain.arn
#}

#output "cloudfront_domain_name" {
#  value = aws_cloudfront_distribution.s3_trackam_domain.domain_name
#}

#output "oac_id" {
#  description = "ID of the CloudFront Origin Access Control"
#  value       = aws_cloudfront_origin_access_control.OAC_cloudfront.id
#}