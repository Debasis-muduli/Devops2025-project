data "aws_iam_policy_document" "assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com", "codebuild.amazonaws.com", "codedeploy.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codepipeline" {
  name               = "codepipeline-role-eu"
  assume_role_policy = data.aws_iam_policy_document.assume.json
}

resource "aws_iam_role" "codebuild" {
  name               = "codebuild-role-eu"
  assume_role_policy = data.aws_iam_policy_document.assume.json
}

output "codepipeline_role_arn" {
  value = aws_iam_role.codepipeline.arn
}

output "codebuild_role_arn" {
  value = aws_iam_role.codebuild.arn
}

