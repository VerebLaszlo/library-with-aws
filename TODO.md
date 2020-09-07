# Spring
## Rest
*[x] HTTP GET http://library.epam.com/api/v1/books //Get all books
*[x] HTTP POST http://library.epam.com/api/v1/books //Create new book
*[ ] HTTP GET http://library.epam.com/api/v1/books/{id} //Get device for given Id/Isbn
*[ ] HTTP PUT http://library.epam.com/api/v1/books/{id} //Update device for given Id/Isbn
*[ ] HTTP DELETE http://library.epam.com/api/v1/books/{id} //Delete device for given Id/Isbn

## Other
*[x] Image of the book
*[ ] Swagger

## Arhitecture
*[ ] ArchUnit
*[ ] Modules

# AWS
*[x] Multi-region
*[x] DynamoDB
*[x] Images stored in S3 and served by CloudFront
*[x] By default there is one EC2 in each subnet wrapped with an ASG and can scale to max 3 instances
*[x] there is an ELB attached to the ASG
*[x] VPC with IGW
*[x] Subnets and security groups
*[x] Endpoints accessible from public internet (NACL configured properly)
*[ ] Demo code simulating autoscaling

# Other
*[x] Terraform
*[ ] Gradle
*[ ] Gradle.kt
