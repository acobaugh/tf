terragrunt = {
  remote_state {
    backend = "s3"

    config {
      bucket  = "acobaugh-tfstate-dev-global"
      region  = "us-east-1"
      key     = "${path_relative_to_include()}/terraform.tfstate"
      encrypt = true
    }
  }

  terraform {
    extra_arguments "common_vars" {
      commands = ["init","${get_terraform_commands_that_need_vars()}"]

      optional_var_files = [
        "${get_parent_tfvars_dir()}/${path_relative_from_include()}/account.tfvars",
        "${get_parent_tfvars_dir()}/${path_relative_from_include()}/region.tfvars",
        "${get_tfvars_dir()}/${path_relative_from_include()}/account.tfvars",
        "${get_tfvars_dir()}/${path_relative_from_include()}/region.tfvars",
      ]
    }
  }
}
