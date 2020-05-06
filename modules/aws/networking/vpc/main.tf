resource "aws_vpc" "vpc" {
  count                            = length(var.cidr) > 0 ? 1 : 0
  cidr_block                       = var.cidr
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = var.enable_ipv6

  tags = merge(
    {
      "Name" = format("%s-%s", var.environment, var.name)
    },
    var.tags,
    var.vpc_tags,
  )
}

