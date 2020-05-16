resource "aws_vpc" "vpc" {
  count                            = var.create_vpc ? 1 : 0
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


# resource allows further IPv4 CIDR blocks to be added to the VPC.

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  count = var.create_vpc && length(var.secondary_cidr_blocks) > 0 ? length(var.secondary_cidr_blocks) : 0

  vpc_id = aws_vpc.vpc[0].id

  cidr_block = element(var.secondary_cidr_blocks, count.index)
}

#Retrieve information about an EC2 DHCP Options configuration.

resource "aws_vpc_dhcp_options" "dns_resolver" {
  count = var.create_vpc && var.enable_dhcp_options ? 1 : 0

  domain_name          = format("%s.%s", var.environment, var.dhcp_options_domain_name)
  domain_name_servers  = var.dhcp_options_domain_name_servers 

  tags = merge(
    {
      "Name" = format("%s-%s", var.environment, var.name)
    },
    var.tags
  )
}
