resource "random_password" "password" {
  length           = 18
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

output "espassword" {
  value     = random_password.password.result
  sensitive = true
}

/*  Create a random password with the following requirements:
  - Length: 18
  - Special characters: !#$%&*()-_=+[]{}<>:?
  - Output the password as a sensitive output
  to show the password in the Terraform output
  terraform output espassword
  to regenerate the password
    terraform taint random_password.password
    terraform apply
    terraform output espassword
*/