resource "aws_apigatewayv2_api" "swift-lift-club-api-gateway" {
  name          = "${var.project_name}-http-api"
  description   = "swift-lift-club API_gateway"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "swift-lift-club-apigateway-lambda-integration" {
  api_id               = aws_apigatewayv2_api.swift-lift-club-api-gateway.id
  integration_type     = "AWS_PROXY"
  connection_type      = "INTERNET"
  description          = "swift-lift-club API-gateway-Lambda-integration"
  integration_uri      = var.fare-calculation-function-arn
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_stage" "swift-lift-club-api-gateway-production-stage" {
  api_id        = aws_apigatewayv2_api.swift-lift-club-api-gateway.id
  name          = "v1"
  deployment_id = aws_apigatewayv2_deployment.swift-lift-club-apigateway-prd-deployment.id

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.main_api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}


resource "aws_apigatewayv2_deployment" "swift-lift-club-apigateway-prd-deployment" {
  api_id      = aws_apigatewayv2_api.swift-lift-club-api-gateway.id
  description = "swift-lift-club deployment policy"

  triggers = {
    redeployment = sha1(join(",", tolist([
      jsonencode(aws_apigatewayv2_integration.swift-lift-club-apigateway-lambda-integration),
      jsonencode(aws_apigatewayv2_route.fare-calculation),
      jsonencode(aws_apigatewayv2_route.create-trip-record),
      jsonencode(aws_apigatewayv2_route.update-trip-record),
      jsonencode(aws_apigatewayv2_route.get-weekly-trips)
    ])))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudwatch_log_group" "main_api_gw" {
  name = "/aws/api-gw/${aws_apigatewayv2_api.swift-lift-club-api-gateway.name}"

  retention_in_days = 30
}

data "aws_ssm_parameter" "route_53_hostzone_id" {
  name            = "route_53_hostzone_id"
  with_decryption = true
}
