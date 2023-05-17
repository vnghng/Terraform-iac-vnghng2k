resource "aws_apigatewayv2_api" "this" {
  name          = "nghianv2-apigatewaytest"
  protocol_type = "HTTP"
  description   = "API GW HTTP"
  cors_configuration {
    allow_origins  = ["*"]
    allow_headers  = ["*"]
    allow_methods  = ["*"]
    expose_headers = ["*"]
    max_age        = -1
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "SIT"
  auto_deploy = true
}

resource "aws_apigatewayv2_domain_name" "this" {
  domain_name = "appvay-test.f88test.com"
  domain_name_configuration {
    certificate_arn = "arn:aws:acm:ap-southeast-1:356705062463:certificate/95632837-f48c-4617-84c7-5839d9bce660"
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_api_mapping" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  domain_name = aws_apigatewayv2_domain_name.this.id
  stage       = aws_apigatewayv2_stage.this.id
}

resource "aws_apigatewayv2_vpc_link" "this" {
  name               = "SIT-Appvay-vpclink"
  security_group_ids = [aws_security_group.apigw_vpclink_sg.id]
  subnet_ids         = module.vpc.public_subnets
}