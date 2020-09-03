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
                        .mapToObj(i -> BookModel.builder(format("Isbn %d", i),
                                                         format("Title %d", i),
                                                         format("Author %d", i),
                                                         format("Publisher %d", i),
                                                         format("/book-%d.png", i)).build())
                        .collect(Collectors.toList());
    }

    @Bean
    @Profile("!prod")
    public AmazonDynamoDB embeddedDynamoDB() {
        var amazonDynamoDB = DynamoDBEmbedded.create().amazonDynamoDB();
        createTable(amazonDynamoDB, readCapacity, writeCapacity);
        return amazonDynamoDB;
    }

    private static CreateTableResult createTable(@NotNull AmazonDynamoDB ddb, long readCapacity, long writeCapacity) {
        return ddb.createTable(createTableCreationRequest(readCapacity, writeCapacity));
    }

    private static CreateTableRequest createTableCreationRequest(long readCapacity, long writeCapacity) {
        return new CreateTableRequest()
                .withTableName(BookModel.TABLE_NAME)
                .withAttributeDefinitions(createAttributeDefinitions())
                .withKeySchema(createKeySchema())
                .withProvisionedThroughput(new ProvisionedThroughput(readCapacity, writeCapacity));
    }

    @Bean
    @Profile("prod")
    AWSCredentialsProvider ec2CredentialsProvider() {
        return InstanceProfileCredentialsProvider.getInstance();
    }

    @NotNull
    private static List<AttributeDefinition> createAttributeDefinitions() {
        return List.of(new AttributeDefinition(BookModel.HASH_KEY_NAME, ScalarAttributeType.S));
    }

    @NotNull
    private static List<KeySchemaElement> createKeySchema() {
        return List.of(new KeySchemaElement(BookModel.HASH_KEY_NAME, KeyType.HASH));
    }
    //endregion
}

