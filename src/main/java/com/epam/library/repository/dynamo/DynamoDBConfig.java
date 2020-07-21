package com.epam.library.repository.dynamo;

import com.epam.library.util.*;

import com.amazonaws.auth.*;
import com.amazonaws.auth.profile.*;
import com.amazonaws.regions.*;
import com.amazonaws.services.dynamodbv2.*;
import com.amazonaws.services.dynamodbv2.datamodeling.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.context.annotation.*;

@SuppressWarnings("squid:S1258")
@Justification("Autopopulated using @Value annotation")
@Configuration
@Profile({"dev", "prod"})
class DynamoDBConfig {

    @Value("${cloud.aws.region.static}")
    private String region;

    @Bean
    public DynamoDBMapper dynamoDBMapper() {
        return new DynamoDBMapper(amazonDynamoDB(), DynamoDBMapperConfig.DEFAULT);
    }

    @Bean
    public AmazonDynamoDB amazonDynamoDB() {
        return AmazonDynamoDBClientBuilder.standard()
                                          .withCredentials(null)
                                          .withRegion(Regions.fromName(region))
                                          .build();
    }

    @Bean
    @Profile("dev")
    AWSCredentialsProvider credentialsProvider() {
        return new ProfileCredentialsProvider();
    }

    @Bean
    @Profile("prod")
    AWSCredentialsProvider ec2CredentialsProvider() {
        return InstanceProfileCredentialsProvider.getInstance();
    }
}

