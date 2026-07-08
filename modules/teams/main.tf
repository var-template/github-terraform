resource "github_team" "ctos" {
  name        = "ctos"
  description = "ctos team"
}

resource "github_team_members" "ctos_members" {
  team_id  = github_team.ctos.id
  for_each = var.teams["ctos"].members

  members {
    username = each.value.username
    role     = each.value.role
  }
}
