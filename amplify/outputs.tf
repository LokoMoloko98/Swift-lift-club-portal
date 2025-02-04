# Outputs
output "amplify_app_url" {
  value = "https://${aws_amplify_domain_association.example.domain_name}"
}

output "app_id" {
  value = aws_amplify_app.swift_lift_app.id
}
