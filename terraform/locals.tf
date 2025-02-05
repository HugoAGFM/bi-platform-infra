locals {
  env = {
    default = {
      region              = "eastus"
      resource_group_name = "bi-platform-${terraform.workspace}"
      adf_name            = "adf-bi-platform-${terraform.workspace}"
      kv_name             = "kv-bi-platform-${terraform.workspace}"
      adbw_name             = "adbw-bi-platform-${terraform.workspace}"
    }

    dev = {
      env = "dev"
    }

    prd = {
      env = "prd"
    }
  }
  environmentvars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace       = merge(local.env["default"], local.env[local.environmentvars])
}