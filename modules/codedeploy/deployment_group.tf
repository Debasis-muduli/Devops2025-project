resource "aws_iam_role" "codedeploy_service_role" {
  name = "codedeploy-service-role-eu"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "codedeploy.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_attach" {
  role       = aws_iam_role.codedeploy_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

resource "aws_codedeploy_deployment_group" "group" {
  app_name              = aws_codedeploy_app.app.name
  deployment_group_name = "sample-deployment-group-eu"
  service_role_arn      = aws_iam_role.codedeploy_service_role.arn

  deployment_style {
    deployment_type   = "IN_PLACE"
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
  }

  ec2_tag_filter {
    key   = "Name"
    type  = "KEY_AND_VALUE"
    value = "MyAppServer"
  }
}

