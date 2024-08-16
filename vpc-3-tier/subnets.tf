# https://visualsubnetcalc.com/index.html?c=1N4IgbiBcIIwgNCAtlEBBA6gZQSAzlKDAAwB0ZFA9DAGyGwXnnUDs9JTVMAHO41wE4+nZgCZiw-pVFxIoAPoA7VAAUATgBMABAFotAdwCmAI1zyAxqhABfRBzLcxshcujrteo6cQWr12wxMtGIScoFkwcTSziBKqpq6WgCGAA4pZpbQNnaMogAsTvRxbgl6qek+mSA2-jlMAMyizDBCYfakjSGSHU1RMkWuIO6JGt6xVdnhpHlU-WHFQ6Vaoxl+Ae15jn2hLqh4KUlqhloAFCmaAJSrWf7rjDQFUTzdD82tRPeP0jtTr30xCywABcAOaJLzXap3JgsXrRAaoYFgzwmSE1OoOWY-drcWYAwZIxLlNHQhxbeHzAmgolpEm1KYCGhvbqMrptRis-4I6CEvQrSp+DGkEhfOa7HnUvljXw3UnCmBw8Tc-AHI6nPCgq4C2X09oK8kwNjsoKiA28Y0RU3Mi3Cq3bbr6wqU1AAYQA9khwajtVChTB6kyuc7oO7PSjpRNdYwYHlRdjo7GneKQKGaRVxoKpjAAKyK-Guj1puly2iCB00LHlvHK1NSkl+mjksWxQa15YRtZ+liB77K-aHY4ncwerUZnV+gRw57BlUD4v+IA

locals {
  subnet_configuration = jsondecode(file(var.subnet_configuration_file))
  web_subnet_configuration = {
    for k, v in local.subnet_configuration.web_subnet_configuration : k => v
    if !var.exclude_stg_environment || v.env != "stg"
  }
  app_subnet_configuration = {
    for k, v in local.subnet_configuration.app_subnet_configuration : k => v
    if !var.exclude_stg_environment || v.env != "stg"
  }
  db_subnet_configuration = {
    for k, v in local.subnet_configuration.db_subnet_configuration : k => v
    if !var.exclude_stg_environment || v.env != "stg"
  }
}

resource "aws_subnet" "web" {
  for_each          = local.web_subnet_configuration
  vpc_id            = aws_vpc.common.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Environment = each.value.env
    Name        = each.key
    Zone        = "web"
    ProjectCode = var.project_code
    SubnetType  = "public"
    UsableHosts = each.value.usable_hosts
    VpcId       = aws_vpc.common.id
    VpcName     = local.vpc_name
  }
}

resource "aws_route_table_association" "web" {
  for_each       = local.web_subnet_configuration
  route_table_id = aws_route_table.web.id
  subnet_id      = aws_subnet.web[each.key].id
}

resource "aws_subnet" "app" {
  for_each          = local.app_subnet_configuration
  vpc_id            = aws_vpc.common.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Environment = each.value.env
    Name        = each.key
    Zone        = "app"
    ProjectCode = var.project_code
    SubnetType  = "private"
    UsableHosts = each.value.usable_hosts
    VpcId       = aws_vpc.common.id
    VpcName     = local.vpc_name
  }
}

resource "aws_route_table_association" "app" {
  for_each       = local.app_subnet_configuration
  route_table_id = aws_route_table.app.id
  subnet_id      = aws_subnet.app[each.key].id
}

resource "aws_subnet" "db" {
  for_each          = local.db_subnet_configuration
  vpc_id            = aws_vpc.common.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Environment = each.value.env
    Name        = each.key
    Zone        = "db"
    ProjectCode = var.project_code
    SubnetType  = "private"
    UsableHosts = each.value.usable_hosts
    VpcId       = aws_vpc.common.id
    VpcName     = local.vpc_name
  }
}

resource "aws_route_table_association" "db" {
  for_each       = local.db_subnet_configuration
  route_table_id = aws_route_table.db.id
  subnet_id      = aws_subnet.db[each.key].id
}
