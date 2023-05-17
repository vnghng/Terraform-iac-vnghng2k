resource "aws_apigatewayv2_integration" "growth_appvay" {
  api_id             = aws_apigatewayv2_api.this.id
  description        = "Growth AppVay Admin"
  integration_type   = "HTTP_PROXY"
  integration_uri    = aws_alb_listener.http.arn
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.this.id

  request_parameters = {
    "overwrite:path" = "/api/admin/$request.path.proxy"
  }
}