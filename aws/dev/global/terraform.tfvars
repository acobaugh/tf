terragrunt = {
  remote_state {
    backend = "s3"

    config {
      bucket  = "acobaugh-tfstate-dev-us-east-1"
      region  = "us-east-1"
      key     = "${path_relative_to_include()}/terraform.tfstate"
      encrypt = true
    }
  }

  terraform {
    extra_arguments "common_vars" {
      commands = ["${get_terraform_commands_that_need_vars()}"]

      optional_var_files = [
        "${find_in_parent_folders("account.tfvars", "ignore")}",
        "${find_in_parent_folders("region.tfvars", "ignore")}",
      ]
    }
  }
}
