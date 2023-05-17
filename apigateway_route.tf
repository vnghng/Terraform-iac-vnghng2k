resource "aws_apigatewayv2_route" "growth_appvay" {
  api_id             = aws_apigatewayv2_api.this.id
  route_key          = "GET /growth/appvay/api/admin/{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.growth_appvay.id}"
}
resource "aws_apigatewayv2_route" "growth_avadm_r2" {
  api_id             = aws_apigatewayv2_api.this.id
  route_key          = "POST /growth/appvay/api/admin/{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.growth_appvay.id}"
}
resource "aws_apigatewayv2_route" "growth_avadm_r3" {
  api_id             = aws_apigatewayv2_api.this.id
  route_key          = "PUT /growth/appvay/api/admin/{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.growth_appvay.id}"
}
resource "aws_apigatewayv2_route" "growth_avadm_r4" {
  api_id             = aws_apigatewayv2_api.this.id
  route_key          = "DELETE /growth/appvay/api/admin/{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.growth_appvay.id}"
}