# script parameters
variable project-name {}

variable tags { type = map(string) }

# configuration parameters
variable vpc-id {}

variable s3-bucket-name {}

variable cloudfront-domain-name {}

variable image-id {}

variable instance-type {}

variable subnet-ids {}

variable dep-target-group {}

variable ec2-instance-profile {}

variable accessArtifactInS3-policy {}
