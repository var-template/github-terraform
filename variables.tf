variable "app_pem_file" {
  type      = string
  sensitive = true
}

variable "members" {
  type = map(object({
    username = string
    role     = string # "admin" or "member"
  }))
}

variable "teams" {
  type = map(object({
    name        = string
    description = string
    privacy     = string
    members = map(object({
      username = string
      role     = string # "member" or "maintainer"
    }))
  }))
}
