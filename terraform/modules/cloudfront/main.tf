# ==========================================================================================
# Origin Access Control (OAC) for Cloudfront so Cloudfront can securely access my S3 bucket.
# ==========================================================================================
#resource "aws_cloudfront_origin_access_control" "OAC_cloudfront" {
#  name                              = "trackam-cloudfront-${var.bucket_name}" # name built from variables 
#  description                       = "OAC for Trackam static website"
 # origin_access_control_origin_type = "s3" # means the origin is an Amazon S3 bucket.
#  signing_behavior                  = "always" #CloudFront will always sign requests to S3.
#  signing_protocol                  = "sigv4" #used to sign in so so that cloufront request to S3 are Authenticated

#}

# ==========================================================================================
# CloudFront Distribution
# ==========================================================================================
#resource "aws_cloudfront_distribution" "s3_trackam_domain" {
#  enabled             = true #Turns on the distribution. 
#  default_root_object = "index.html" # If no file is specified in the URL, CloudFront serves index.html
#  origin {
    #domain_name              = var.bucket_domain # The S3 bucket’s domain name
   # origin_access_control_id = aws_cloudfront_origin_access_control.OAC_cloudfront.id # Links to the OAC created earlier so S3 can be private but still serve via CloudFront.
  #  origin_id                = "distribution" #  Unique ID for this origin
 # }

#  viewer_certificate {
  #  cloudfront_default_certificate = true
 # }

#  default_cache_behavior {
   # allowed_methods  = ["GET", "HEAD"] # CloudFront will only allow GET and HEAD requests.
  #  cached_methods   = ["GET", "HEAD"] # Only GET and HEAD are cached
 #   target_origin_id = "distribution"
#    viewer_protocol_policy = "allow-all" # Redirects HTTP requests to HTTPS.

 #   forwarded_values {
#      query_string = false # No query strings or cookies are forwarded (good for caching efficiency).


    #  cookies {
   #     forward = "none"
  #    }
 #   }

    # Define additional cache behaviors for specific path patterns
    # cache_behavior {
    #   path_pattern          = "/images/*"
    #   allowed_methods      = ["GET", "HEAD"]
    #   cached_methods       = ["GET", "HEAD"]
    #   target_origin_id     = "distribution"
    #   min_ttl              = 0
    #   default_ttl          = 3600
    #   max_ttl              = 86400
    #   viewer_protocol_policy = "redirect-to-https"

    # cache_behavior {
    #   path_pattern          = "/api/*"
    #   allowed_methods      = ["GET", "HEAD", "OPTIONS"]
    #   cached_methods       = ["GET", "HEAD", "OPTIONS"]
    #   target_origin_id     = "distribution"
    #   min_ttl              = 0
    #   default_ttl          = 0
    #   max_ttl              = 0
    #   viewer_protocol_policy = "https-only"

    #   forwarded_values {
    #     query_string = true
    #     cookies {
    #       forward = "none"
    #     }
    #   }
    # }
#    min_ttl                = 0
#    default_ttl            = 3600
#    max_ttl                = 86400
#  }

#  price_class = "PriceClass_200"

# price_class → Chooses which CloudFront locations to use (affects speed & cost)
# PriceClass_All   = All locations (fastest, most expensive)
# PriceClass_200   = Most locations, except the priciest (balanced)
# PriceClass_100   = Only cheapest locations (cheapest, slower)
# viewer_protocol_policy → Controls how CloudFront handles HTTP vs HTTPS requests:
# redirect-to-https = Force redirect from HTTP to HTTPS (recommended for security).
# https-only        = Block HTTP completely, allow only HTTPS.
# allow-all         = Accept both HTTP and HTTPS.
# min_ttl     → Minimum seconds CloudFront keeps a file before re-checking.
# default_ttl → Default cache time if no Cache-Control is set.
# max_ttl     → Maximum time CloudFront will keep a file before re-checking.


 # No geographic restriction — users from all countries can access.
#  restrictions { 
#    geo_restriction {
   #   restriction_type = "none"
  #    locations        = []
 #   }
#  }

#  tags = {
   # Environment = "production"
  #  Name        = "Track Am Frontend App"
 # }
#}
# ==========================================================================================
# Bucket policy to allow CloudFront
# ==========================================================================================

#resource "aws_s3_bucket_policy" "cloudfront_access" {
 #  bucket = var.bucket_name
#
#   policy = jsonencode({
    # Version = "2012-10-17",
   #  Statement = [
  #     {
 #        Sid       = "AllowCloudFrontAccessOnly",
#         Effect    = "Allow",
        # Principal = {
       #    Service = "cloudfront.amazonaws.com"
      #   },
     #    Action    = "s3:GetObject",
    #     Resource  = "${var.bucket_arn}/*"
   #    }
  #   ]
 #  })
#}