data "terraform_remote_state" "aws_dev_vpc" {
  backend = "remote"
  config = {
    organization = "djoo-hashicorp"
    workspaces = {
      name = "tf-aws-network-dev"
    }
  }
}
data "hcp_packer_version" "aap" {
  bucket_name  = var.bucket_name
  channel_name = var.channel_name
}

data "hcp_packer_artifact" "rhel9_aap" {
  bucket_name         = var.bucket_name
  version_fingerprint = data.hcp_packer_version.aap.fingerprint
  platform            = "aws"
  region              = var.aws_region
}
