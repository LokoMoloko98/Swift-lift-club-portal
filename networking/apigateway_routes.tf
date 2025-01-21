resource "aws_apigatewayv2_route" "fare-calculation" {
  api_id    = aws_apigatewayv2_api.swift-lift-club-api-gateway.id
  route_key = "POST /fare"
  target    = "integrations/${aws_apigatewayv2_integration.swift-lift-club-apigateway-lambda-integration.id}"
}
