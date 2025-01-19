resource "aws_apigatewayv2_route" "create-blog" {
  api_id    = aws_apigatewayv2_api.moloko-blog-api-gateway.id
  route_key = "PUT /blogs"
  target    = "integrations/${aws_apigatewayv2_integration.moloko-blog-apigateway-lambda-integration.id}"
}

resource "aws_apigatewayv2_route" "get-a-blog" {
  api_id    = aws_apigatewayv2_api.moloko-blog-api-gateway.id
  route_key = "GET /blogs/{BlogId}"
  target    = "integrations/${aws_apigatewayv2_integration.moloko-blog-apigateway-lambda-integration.id}"
}

resource "aws_apigatewayv2_route" "get-all-blogs" {
  api_id    = aws_apigatewayv2_api.moloko-blog-api-gateway.id
  route_key = "GET /blogs"
  target    = "integrations/${aws_apigatewayv2_integration.moloko-blog-apigateway-lambda-integration.id}"
}

resource "aws_apigatewayv2_route" "delete-blog" {
  api_id    = aws_apigatewayv2_api.moloko-blog-api-gateway.id
  route_key = "DELETE /blogs/{BlogId}"
  target    = "integrations/${aws_apigatewayv2_integration.moloko-blog-apigateway-lambda-integration.id}"
}