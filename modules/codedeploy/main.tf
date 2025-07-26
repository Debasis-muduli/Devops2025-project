resource "aws_codedeploy_app" "app" {
  name             = "codedeploy-app-eu"
  compute_platform = "Server"
}

output "app_name" {
  value = aws_codedeploy_app.app.name
}

