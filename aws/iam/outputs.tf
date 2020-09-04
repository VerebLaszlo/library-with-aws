// Outputs
output ec2-instance-profile-name {
  value = aws_iam_instance_profile.ip-assumeEC2Role.name
}

output accessArtifactInS3-policy {
  value = aws_iam_role_policy_attachment.rpa-copyS3ToEC2
}
