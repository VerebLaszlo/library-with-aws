package com.epam.library.repository.dynamo;

import com.epam.library.util.*;

import com.amazonaws.auth.*;
import com.amazonaws.regions.*;
import com.amazonaws.services.dynamodbv2.*;
import com.amazonaws.services.dynamodbv2.datamodeling.*;
import com.amazonaws.services.dynamodbv2.local.embedded.*;
import com.amazonaws.services.dynamodbv2.model.*;
import org.jetbrains.annotations.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.context.annotation.*;

import java.util.*;
import java.util.stream.*;

import static java.lang.String.*;

@SuppressWarnings("squid:S1258")
@Justification("Autopopulated using @Value annotation")
@Configuration
class DynamoDBConfig {
    private static final int NUMBER_OF_BOOKS = 5;

    @Value("${cloud.aws.region.static}")
    private String region;
    @Value("${dynamo.readCapacity}")
    private long readCapacity;
    @Value("${dynamo.writeCapacity}")
    private long writeCapacity;

    @Bean
    @Profile("!dev")
    public DynamoDBMapper dynamoDBMapper() {
        return new DynamoDBMapper(null);
    }

    @Bean
    @Profile("dev")
    public DynamoDBMapper initializedDBMapper(AmazonDynamoDB dynamoDB) {
        DynamoDBMapper dynamoDBMapper = new DynamoDBMapper(dynamoDB);
        dynamoDBMapper.batchSave(generateBooks());
        return dynamoDBMapper;
    }

    @Bean
    @Profile("prod")
    public AmazonDynamoDB amazonDynamoDB() {
        return AmazonDynamoDBClientBuilder.standard()
                                          .withCredentials(null)
                                          .withRegion(Regions.fromName(region))
                                          .build();
    }

    //region helper functions
    @NotNull
    private static List<BookModel> generateBooks() {
        return IntStream.range(0, NUMBER_OF_BOOKS)
                        .mapToObj(i -> new BookModel(null,
                                                     "Isbn " + i,
                                                     "Title " + i,
                                                     "Author " + i,
                                                     "Publisher " + i,
                                                     format("img/book-%d.png", i)))
                        .collect(Collectors.toList());
    }

    @Bean
    @Profile("!prod")
    public AmazonDynamoDB embeddedDynamoDB() {
        var amazonDynamoDB = DynamoDBEmbedded.create().amazonDynamoDB();
        createTable(amazonDynamoDB);
        return amazonDynamoDB;
    }

    @Bean
    @Profile("prod")
    AWSCredentialsProvider ec2CredentialsProvider() {
        return InstanceProfileCredentialsProvider.getInstance();
    }

    private CreateTableResult createTable(AmazonDynamoDB ddb) {
        return ddb.createTable(createTableCreationRequest(BookModel.TABLE_NAME, BookModel.HASH_KEY_NAME));
    }

    private CreateTableRequest createTableCreationRequest(String tableName, String hashKeyName) {
        return new CreateTableRequest()
                .withTableName(tableName)
                .withAttributeDefinitions(createAttributeDefinitions(hashKeyName))
                .withKeySchema(createKeySchema(hashKeyName))
                .withProvisionedThroughput(new ProvisionedThroughput(readCapacity, writeCapacity));
    }

    @NotNull
    private static List<AttributeDefinition> createAttributeDefinitions(String hashKeyName) {
        return List.of(new AttributeDefinition(hashKeyName, ScalarAttributeType.S));
    }

    @NotNull
    private static List<KeySchemaElement> createKeySchema(String hashKeyName) {
        return List.of(new KeySchemaElement(hashKeyName, KeyType.HASH));
    }
    //endregion
}

