variable "build_role_arn" {}

resource "aws_codebuild_project" "build" {
  name         = "build-project-eu"
  service_role = var.build_role_arn

  artifacts { type = "CODEPIPELINE" }

  environment {
    compute_type      = "BUILD_GENERAL1_SMALL"
    image             = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type              = "LINUX_CONTAINER"
    privileged_mode   = true
  }

  source { type = "CODEPIPELINE" }
}

output "project_name" {
  value = aws_codebuild_project.build.name
}

