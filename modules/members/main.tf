terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

resource "github_membership" "members" {
  for_each = var.members
  username = each.value.username
  role     = each.value.role
}
