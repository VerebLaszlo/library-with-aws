# shellcheck disable=SC2016

cd /home/ec2-user
FILE=$(aws s3api list-objects-v2 --bucket "${s3_bucket_name}" \
  --query 'sort_by(Contents[?contains(Key, `-RELEASE.war`) && contains(Key, `library-`) && !contains(Key, `.war.`)], &LastModified)[-1].Key' --output=text);
aws s3 cp "s3://${s3_bucket_name}/$FILE" library.war
aws s3 cp "s3://${s3_bucket_name}/release/log4j2.yaml" log4j2.yaml
aws s3 cp "s3://${s3_bucket_name}/release/run-library.sh" run-library.sh

java -Dlogging.config=file:log4j2.yaml -jar library.war
