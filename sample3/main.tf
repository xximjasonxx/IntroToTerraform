
module aws {
  source    = "./modules/aws"
}

module azure {
  source    = "./modules/azure"

  bucket_name = module.aws.bucket_name
}