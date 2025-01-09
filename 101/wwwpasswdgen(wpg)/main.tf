variable "length" {
  description = "The length input from the user"
  type        = number
  default     = 18
}
resource "random_password" "password" {
  length           = var.length
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"

  keepers = {
    # this will recreate the password if the timestamp changes: meaning every running will generate a new password
    timestamp = "${timestamp()}"
  }
}

output "espassword" {
  value     = random_password.password.result
  sensitive = true
}