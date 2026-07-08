variable "members" {
  type = map(object({
    username = string
    role     = string
  }))
}