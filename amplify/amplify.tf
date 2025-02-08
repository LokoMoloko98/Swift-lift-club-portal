# Get existing hosted zone
data "aws_ssm_parameter" "route_53_hostzone_id" {
  name            = "route_53_hostzone_id"
  with_decryption = true
}

data "aws_ssm_parameter" "github_access_token" {
  name = "Github_PAT"
  with_decryption = true
}


resource "aws_amplify_app" "swift_lift_app" {
  name       = "${var.project_name}-app"
  repository   = var.repository_url
  access_token = data.aws_ssm_parameter.github_access_token.value

  # Enable auto branch creation
  enable_auto_branch_creation = true
  enable_branch_auto_build   = true

  iam_service_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/amplify-service-role-${data.aws_caller_identity.current.account_id}"
  platform = "WEB_COMPUTE"

  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - npm ci --cache .npm --prefer-offline
        build:
          commands:
            - npm run build
      artifacts:
        baseDirectory: .next
        files:
          - "**/*"
      cache:
        paths:
          - .next/cache/**/*
          - .npm/**/*
  EOT

  # The default rewrites and redirects added by the Amplify Console.
custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }

# Environment variables
  environment_variables = {
    _BUILD_TIMEOUT = "5"
  }
}

resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.swift_lift_app.id
  branch_name = "main"

  framework = "Next.js - SSR"
  stage     = "PRODUCTION"


  enable_auto_build = true
}

resource "aws_amplify_domain_association" "swift_lift_app_dns" {
  app_id      = aws_amplify_app.swift_lift_app.id
  domain_name = "moloko-mokubedi.co.za"
  wait_for_verification = false
  depends_on = [aws_amplify_app.swift_lift_app]
  sub_domain {
    branch_name = aws_amplify_branch.main.branch_name
    prefix      = "swift-lift-club"
  }
}

resource "aws_route53_record" "swift_lift" {
  zone_id = data.aws_ssm_parameter.route_53_hostzone_id.value
  name    = "swift-lift-club.moloko-mokubedi.co.za"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_amplify_domain_association.swift_lift_app_dns.domain_name}"]
}
