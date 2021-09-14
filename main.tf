module "s3_public" {
  source = "./modules/s3"
  name = "selleo-jswob-public"
  env = "development"
}