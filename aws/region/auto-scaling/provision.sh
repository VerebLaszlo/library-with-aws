#!/bin/bash
# shellcheck disable=SC2016
sudo yum update -y
sudo yum install java-11-amazon-corretto.x86_64 htop -y

# TODO remove the not used method
echo "export LIBRARY_CLOUDFRONT=\"https://${cloudfront_domain_name}\"" >> /etc/environment
echo "export LIBRARY_CLOUDFRONT=\"https://${cloudfront_domain_name}\"" >> /etc/profile.d/library_init.sh
chmod +x /etc/profile.d/library_init.sh
source /etc/profile.d/library_init.sh

USER_HOME="/home/ec2-user"
FILE=$(aws s3api list-objects-v2 --bucket "${s3_bucket_name}" \
  --query 'sort_by(Contents[?contains(Key, `-RELEASE.jar`) && contains(Key, `library-`) && !contains(Key, `.jar.`)], &LastModified)[-1].Key' --output=text);
aws s3 cp "s3://${s3_bucket_name}/$FILE" "$USER_HOME"/library.jar

cd $USER_HOME
java -jar library.jar
