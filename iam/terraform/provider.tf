terraform {
  required_version = ">= 1.1"

}

provider "aws" {
  # Ireland ftw
  region = "eu-west-1"

  # Since there is no proper AWS account, just ignore these so we can run the planning stage to validate our code
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  access_key                  = "nope"
  secret_key                  = "nope"

  default_tags {
    tags = {
      provisioner = "github:engineering-stuff"
    }
  }
}
