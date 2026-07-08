resource "github_membership" "members" {
  for_each = var.members
  username = each.value.username
  role     = each.value.role
}
