resource "aws_acm_certificate" "swift-lift-club-cert" {
  domain_name       = "auth-swift-lift-club.moloko-mokubedi.co.za"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}