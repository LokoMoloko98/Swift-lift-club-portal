# Outputs
output "amplify_app_url" {
  value = "https://${aws_amplify_domain_association.swift_lift_app_dns.domain_name}"
}

output "amplify_app_id" {
  value = aws_amplify_app.swift_lift_app.id
}