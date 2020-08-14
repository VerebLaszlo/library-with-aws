#!/bin/bash
# shellcheck disable=SC2016
sudo yum update -y
sudo yum install java-11-amazon-corretto.x86_64 htop -y

FILE=$(aws s3api list-objects-v2 --bucket "${s3_bucket_name}" \
  --query 'sort_by(Contents[?contains(Key, `-RELEASE.jar`) && contains(Key, `library-`) && !contains(Key, `.jar.`)], &LastModified)[-1].Key' --output=text);
aws s3 cp "s3://${s3_bucket_name}/$FILE" "$HOME"/library.jar
java -jar "$HOME"/library.jar
