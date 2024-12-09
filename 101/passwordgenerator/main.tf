variable "length" {
  description = "The length input from the user"
  type        = number
    default     = 18
}
resource "random_password" "password" {
  length           = var.length
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

output "espassword" {
  value     = random_password.password.result
  sensitive = true
}

/*  Create a random password with the following requirements:
  - Length: 18 default value
  to change the length, use the following command
  export TF_VAR_length=20 in the shell changing the lenght will regenerate the password
   
   Can also be done using the following command: terraform apply -var 'length=20' -auto-approve
  - Special characters: !#$%&*()-_=+[]{}<>:?
  - Output the password as a sensitive output
  to show the password in the Terraform output
  terraform output espassword
  to regenerate the password
    terraform taint random_password.password
    terraform apply
    terraform output espassword
*/