terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

locals {
  github_organization = "var-template"
  app_id              = "4244361"
  app_installation_id = "Iv23ctKOEm5D6o1ooeyq"
}
