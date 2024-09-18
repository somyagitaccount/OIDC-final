
variable "url" {
  type = string
  description = "url of github token action"
  default = "https://token.actions.githubusercontent.com"
}


variable "client_id_listl" {
  type = list(string)
  description = "client id list string"
  default = ["sts.amazonaws.com"]
}


