# Spring
## Rest
*[x] HTTP GET http://library.epam.com/api/v1/books //Get all books
*[x] HTTP POST http://library.epam.com/api/v1/books //Create new book
*[ ] HTTP GET http://library.epam.com/api/v1/books/{id} //Get device for given Id/Isbn
*[ ] HTTP PUT http://library.epam.com/api/v1/books/{id} //Update device for given Id/Isbn
*[ ] HTTP DELETE http://library.epam.com/api/v1/books/{id} //Delete device for given Id/Isbn

## Other
*[ ] Image of the book
*[ ] Swagger

## Arhitecture
*[ ] ArchUnit
*[ ] Modules

# AWS
*[ ] Multi-region
*[x] DynamoDB
*[ ] Images stored in S3 and served by CloudFront
*[ ] By default there is one EC2 in each subnet wrapped with an ASG and can scale to max 3 instances
*[ ] there is an ELB attached to the ASG
*[ ] VPC with IGW
*[ ] Subnets and security groups
*[ ] Endpoints accessible from public internet (NACL configured properly)
*[ ] Demo code simulating autoscaling

# Other
*[ ] Terraform
*[ ] Gradle
*[ ] Gradle.kt
