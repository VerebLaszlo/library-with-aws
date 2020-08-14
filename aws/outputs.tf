# Outputs
output s3-id {
  value = aws_s3_bucket.library-learning.id
}

output lb-url {
  value = [ module.us-east-1.lb-url]
}
