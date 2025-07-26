provider "aws" {
  region = var.aws_region
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.artifact_bucket
}

module "iam" {
  source = "./modules/iam"
}

module "codebuild" {
  source          = "./modules/codebuild"
  build_role_arn  = module.iam.codebuild_role_arn
}

module "codedeploy" {
  source = "./modules/codedeploy"
}

module "codepipeline" {
  source                = "./modules/codepipeline"
  artifact_bucket       = var.artifact_bucket
  codebuild_project     = module.codebuild.project_name
  codedeploy_app_name   = module.codedeploy.app_name
  deployment_group_name = module.codedeploy.deployment_group_name
  pipeline_role_arn     = module.iam.codepipeline_role_arn
  github_token          = var.github_token
  github_owner          = var.github_owner
  github_repo           = var.github_repo
  github_branch         = var.github_branch
  depends_on            = [module.s3]
}

