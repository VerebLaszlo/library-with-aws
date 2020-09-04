# IAM configuration
resource aws_iam_policy policy-accessBooksTable {
  name="AccessBooksTable"
  description = "Allows editing items in the Books table"
  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:DeleteItem",
                "dynamodb:GetItem",
                "dynamodb:Scan",
                "dynamodb:Query",
                "dynamodb:UpdateItem"
            ],
            "Resource": [
                "arn:aws:dynamodb:us-east-1:686177639067:table/Books/index/id",
                "arn:aws:dynamodb:us-east-1:686177639067:table/Books"
            ]
        }
    ]
  }
  EOF
}

resource aws_iam_policy policy-accessArtifactInS3 {
  name = "CopyS3ToEC2"
  description = "Allows copying objects form the Library Learning bucket"
  policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "ViewLibraryBucket",
          "Effect": "Allow",
          "Action": "s3:ListBucket",
          "Resource": "arn:aws:s3:::library-learning"
        },
        {
          "Sid": "GetObjectsInLibraryBucket",
          "Effect": "Allow",
          "Action": [
            "s3:GetObject"
          ],
          "Resource": [
            "arn:aws:s3:::library-learning/release/com/epam/library/*"
          ]
        }
      ]
    }
  EOF
}

resource aws_iam_role role-assumeEC2Role {
  name = "AssumeEC2Role"
  description = "Allows EC2 instances to call AWS services on your behalf."
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = var.tags
}

resource aws_iam_instance_profile ip-assumeEC2Role {
  name = "AssumeEC2Role"
  role = aws_iam_role.role-assumeEC2Role.name
}

resource aws_iam_role_policy_attachment rpa-copyS3ToEC2 {
  role = aws_iam_role.role-assumeEC2Role.name
  policy_arn = aws_iam_policy.policy-accessArtifactInS3.arn
}

resource aws_iam_role_policy_attachment rpa-accessBooksTable {
  role = aws_iam_role.role-assumeEC2Role.name
  policy_arn = aws_iam_policy.policy-accessBooksTable.arn
}
