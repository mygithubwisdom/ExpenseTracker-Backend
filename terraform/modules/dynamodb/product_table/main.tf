#resource "aws_dynamodb_table" "dynamodb-table" {
 # name           = "${var.RESOURCES_PREFIX}-${var.table_name}"
  #billing_mode   = "PROVISIONED"
 # read_capacity  = 5
  #write_capacity = 5
 # hash_key       = ""
 # range_key      = ""

 # attribute {
  #  name = ""
  #  type = "S"
 # }

 # attribute {
  #  name = ""
   # type = "S"
 # }

  #tags = {
  #  Name        = "${var.RESOURCES_PREFIX}-${var.table_name}"
  #  Environment = var.ENV
  #}
#}