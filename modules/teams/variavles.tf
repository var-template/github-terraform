variable "teams" {
  type = map(object({
    name        = string
    description = string
    privacy     = string
    members = map(object({
      username = string
      role     = string
    }))
  }))
}