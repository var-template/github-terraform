resource "github_team" "ctos" {
  name        = "ctos"
  description = "ctos team"
}

resource "github_team_members" "ctos_members" {
  team_id = github_team.ctos.id

  members {
    username = "tsuji-riya"
    role     = "maintainer"
  }

  members {
    username = "proto08"
    role     = "maintainer"
  }
}
