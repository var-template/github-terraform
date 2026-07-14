locals {
  repo_config_files = fileset(path.module, "*/config.yaml")

  repositories = {
    for f in local.repo_config_files :
    dirname(f) => yamldecode(file("${path.module}/${f}"))
  }
}

resource "github_repository" "this" {
  for_each = local.repositories

  name        = each.key
  description = try(each.value.description, "")
  visibility  = try(each.value.visibility, "private")
  topics      = try(each.value.topics, [])

  has_issues   = try(each.value.has_issues, true)
  has_projects = try(each.value.has_projects, false)
  has_wiki     = try(each.value.has_wiki, false)

  allow_merge_commit        = try(each.value.allow_merge_commit, false)
  allow_squash_merge        = try(each.value.allow_squash_merge, true)
  allow_rebase_merge        = try(each.value.allow_rebase_merge, false)
  delete_branch_on_merge    = true
  squash_merge_commit_title = "PR_TITLE"

  auto_init = true

  lifecycle {
    # 誤ってterraform destroy/apply時にリポジトリごと消えるのを防ぐ
    prevent_destroy = true
    ignore_changes = [
      # README等をauto_init後に手動編集しても差分検知しない
      auto_init,
    ]
  }
}

resource "github_repository_vulnerability_alerts" "this" {
  for_each   = local.repositories
  repository = github_repository.this[each.key].name
  enabled    = true
}

resource "github_branch_default" "this" {
  for_each   = local.repositories
  repository = github_repository.this[each.key].name
  branch     = "main"
}

resource "github_repository_ruleset" "main_protection" {
  for_each = local.repositories

  name        = "main-protection"
  repository  = github_repository.this[each.key].name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    deletion         = true
    non_fast_forward = true

    pull_request {
      required_approving_review_count   = try(each.value.required_approving_review_count, 1)
      dismiss_stale_reviews_on_push     = try(each.value.dismiss_stale_reviews_on_push, true)
      require_code_owner_review         = try(each.value.require_code_owner_review, false)
      require_last_push_approval        = try(each.value.require_last_push_approval, false)
      required_review_thread_resolution = try(each.value.required_review_thread_resolution, true)
    }

    required_status_checks {
      strict_required_status_checks_policy = try(each.value.strict_status_checks, true)

      dynamic "required_check" {
        for_each = try(each.value.required_status_checks, [])
        content {
          context = required_check.value
        }
      }
    }
  }

  depends_on = [github_branch_default.this]
}
