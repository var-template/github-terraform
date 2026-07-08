provider "github" {
  owner = local.github_organization
  app_auth {
    id              = local.app_id           # or `GITHUB_APP_ID`
    installation_id = local.app_installation_id # or `GITHUB_APP_INSTALLATION_ID`
    pem_file        = var.app_pem_file        # or `GITHUB_APP_PEM_FILE`
  }
}