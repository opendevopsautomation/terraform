resource "aws_internet_gateway" "igw" {
#   count = var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = format("%s-%s", var.environment, var.name)
    },
    var.tags
  )
}