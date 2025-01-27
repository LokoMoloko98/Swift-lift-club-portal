output "apigateway_arn" {
  value = aws_apigatewayv2_api.swift-lift-club-api-gateway.execution_arn
}

output "apigateway_id" {
  value = aws_apigatewayv2_api.swift-lift-club-api-gateway.id
  
}

output "swift_lift_club_cert_arn" {
  value = aws_acm_certificate.swift-lift-club-cert.arn
}