terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

resource "github_team" "teams" {
  for_each = var.teams

  name        = each.value.name
  description = try(each.value.description, null)
  privacy     = each.value.privacy
}

resource "github_team_members" "members" {
  for_each = var.teams
  team_id  = github_team.teams[each.key].id

  dynamic "members" {
    for_each = each.value.members
    content {
      username = members.value.username
      role     = members.value.role
    }
  }
}
