# Get existing hosted zone
data "aws_ssm_parameter" "route_53_hostzone_id" {
  name            = "route_53_hostzone_id"
  with_decryption = true
}

# Get parameters from Parameter Store
data "aws_ssm_parameter" "authority" {
  name = "/swift-lift/auth/authority"
  with_decryption = true
}

data "aws_ssm_parameter" "client_id" {
  name = "/swift-lift/auth/client_id"
  with_decryption = true
}

data "aws_ssm_parameter" "redirect_uri" {
  name = "/swift-lift/auth/redirect_uri"
  with_decryption = true
}

data "aws_ssm_parameter" "scope" {
  name = "/swift-lift/auth/scope"
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

  # The default build_spec added by the Amplify Console for React.
  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - npm install --legacy-peer-deps
        build:
          commands:
            - echo "REACT_APP_AUTHORITY=$${AUTHORITY}" >> .env
            - echo "REACT_APP_CLIENT_ID=$${CLIENT_ID}" >> .env
            - echo "REACT_APP_REDIRECT_URI=$${REDIRECT_URI}" >> .env
            - echo "REACT_APP_SCOPE=$${SCOPE}" >> .env
            - npm run build
      artifacts:
        baseDirectory: build
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
  EOT

  # The default rewrites and redirects added by the Amplify Console.
custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }

  custom_rule {
    source = "</^[^.]+$|\\.(?!(css|gif|ico|jpg|js|png|txt|svg|woff|ttf|map|json)$)([^.]+$)/>"
    status = "200"
    target = "/index.html"
  }

# Environment variables
  environment_variables = {
    AUTHORITY     = data.aws_ssm_parameter.authority.value
    CLIENT_ID     = data.aws_ssm_parameter.client_id.value
    REDIRECT_URI  = data.aws_ssm_parameter.redirect_uri.value
    SCOPE         = data.aws_ssm_parameter.scope.value
  }
}

resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.swift_lift_app.id
  branch_name = "main"

  framework = "React"
  stage     = "PRODUCTION"

  enable_auto_build = true
}

resource "aws_amplify_domain_association" "swift_lift_app_dns" {
  app_id      = aws_amplify_app.swift_lift_app.id
  domain_name = "moloko-mokubedi.co.za"
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
