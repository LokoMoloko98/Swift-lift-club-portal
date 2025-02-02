resource "aws_apigatewayv2_route" "fare-calculation" {
  api_id             = aws_apigatewayv2_api.swift-lift-club-api-gateway.id
  route_key          = "GET /fare"
  target             = "integrations/${aws_apigatewayv2_integration.swift-lift-club-fare-calculation-apigateway-lambda-integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.swift_lift_club_authorizer.id
}

resource "aws_apigatewayv2_route" "user-profile" {
  api_id             = aws_apigatewayv2_api.swift-lift-club-api-gateway.id
  route_key          = "GET /user/profile"
  target             = "integrations/${aws_apigatewayv2_integration.swift-lift-club-user-profile-apigateway-lambda-integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.swift_lift_club_authorizer.id
}

resource "aws_apigatewayv2_route" "create-trip-record" {
  api_id             = aws_apigatewayv2_api.swift-lift-club-api-gateway.id
  route_key          = "POST /trips/add"
  target             = "integrations/${aws_apigatewayv2_integration.swift-lift-club-trips-ops-apigateway-lambda-integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.swift_lift_club_authorizer.id
}

resource "aws_apigatewayv2_route" "update-trip-record" {
  api_id             = aws_apigatewayv2_api.swift-lift-club-api-gateway.id
  route_key          = "PUT /trips/update"
  target             = "integrations/${aws_apigatewayv2_integration.swift-lift-club-trips-ops-apigateway-lambda-integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.swift_lift_club_authorizer.id
}

resource "aws_apigatewayv2_route" "get-weekly-trips" {
  api_id             = aws_apigatewayv2_api.swift-lift-club-api-gateway.id
  route_key          = "GET /trips/weekly"
  target             = "integrations/${aws_apigatewayv2_integration.swift-lift-club-trips-ops-apigateway-lambda-integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.swift_lift_club_authorizer.id
}
