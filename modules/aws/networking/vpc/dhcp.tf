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

#Associate one DHCP Options Set to a VPC.

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  count = var.create_vpc && var.enable_dhcp_options ? 1 : 0

  vpc_id          = aws_vpc.vpc[0].id
  dhcp_options_id = aws_vpc_dhcp_options.dns_resolver[0].id
}
