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
  app_installation_id = "145146379"
}

module "members" {
  source = "./modules/members"

  members = var.members
}

module "teams" {
  source = "./modules/teams"

  teams = var.teams
}

module "repositories" {
  source = "./modules/repositories"
}
