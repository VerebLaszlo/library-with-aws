#!/bin/bash
# shellcheck disable=SC2016
sudo yum update -y
sudo yum install java-11-amazon-corretto.x86_64 htop -y

echo "export LIBRARY_CLOUDFRONT=\"https://${CLOUDFRONT_DOMAIN_NAME}\"" >> /etc/profile.d/library_init.sh
chmod +x /etc/profile.d/library_init.sh
source /etc/profile.d/library_init.sh

FILE=$(aws s3api list-objects-v2 --bucket "${S3_BUCKET_NAME}" \
  --query 'sort_by(Contents[?contains(Key, `-RELEASE.war`) && contains(Key, `library-`) '`
                       `'&& !contains(Key, `.war.`)], &LastModified)[-1].Key' --output=text);

cd /home/ec2-user || exit
runuser -l ec2-user -c "aws s3 cp \"s3://${S3_BUCKET_NAME}/$FILE\" library.war"
runuser -l ec2-user -c "aws s3 cp \"s3://${S3_BUCKET_NAME}/release/log4j2.yaml\" log4j2.yaml"
runuser -l ec2-user -c "aws s3 cp \"s3://${S3_BUCKET_NAME}/release/run-library.sh\" run-library.sh"
chmod u+x run-library.sh

runuser -l ec2-user -c "java -Dlogging.config=file:log4j2.yaml -jar library.war"
