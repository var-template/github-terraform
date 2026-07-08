variable "members" {
  type = map(object({
    username = string
    role     = string
  }))
}

variable "teams" {
  type = map(object({
    name        = string
    description = string
    members = map(object({
      username = string
      role     = string
    }))
  }))
}