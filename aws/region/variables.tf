# script parameters
variable project-name {}

variable tags { type = map(string) }

# configuration parameters
variable region {}

variable vpc-cidr {}

variable public-cidrs { type = list(string) }

variable private-cidrs { type = list(string) }

variable access-ip {}

variable image-owners {}

variable image-name-prefixes {}

variable instance-type {}

variable s3-bucket-name {}

variable cloudfront-domain-name {}

variable ec2-instance-profile-name {}

variable accessArtifactInS3-policy {}

variable zone-id {}

variable domain-name {}

variable route-policy-weight {}
