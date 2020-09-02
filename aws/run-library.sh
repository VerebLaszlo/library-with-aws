# shellcheck disable=SC2016

cd /home/ec2-user || exit
FILE=$(aws s3api list-objects-v2 --bucket "${S3_BUCKET_NAME}" \
  --query 'sort_by(Contents[?contains(Key, `-RELEASE.war`) && contains(Key, `library-`) "`
                       `"&& !contains(Key, `.war.`)], &LastModified)[-1].Key' --output=text);
aws s3 cp "s3://${S3_BUCKET_NAME}/$FILE" library.war
aws s3 cp "s3://${S3_BUCKET_NAME}/release/log4j2.yaml" log4j2.yaml
aws s3 cp "s3://${S3_BUCKET_NAME}/release/run-library.sh" run-library.sh

java -Dlogging.config=file:log4j2.yaml -jar library.war
