package com.epam.library.repository;

import com.epam.library.repository.dynamo.*;

import com.amazonaws.services.dynamodbv2.*;
import com.amazonaws.services.dynamodbv2.local.embedded.*;
import com.amazonaws.services.dynamodbv2.model.*;
import org.jetbrains.annotations.*;

import org.springframework.boot.test.context.*;
import org.springframework.context.annotation.*;

import java.util.*;

@TestConfiguration
class LibraryConfiguration {

    private static final long READ_CAPACITY = 1000L;
    private static final long WRITE_CAPACITY = 1000L;

    @Bean
    public AmazonDynamoDB amazonDynamoDB() {
        var amazonDynamoDB = DynamoDBEmbedded.create().amazonDynamoDB();
        createTable(amazonDynamoDB, BookModel.TABLE_NAME, BookModel.HASH_KEY_NAME);
        return amazonDynamoDB;
    }

    //region helper functions
    private static CreateTableResult createTable(AmazonDynamoDB ddb, String tableName, String hashKeyName) {
        return ddb.createTable(createTableCreationRequest(tableName, hashKeyName));
    }

    private static CreateTableRequest createTableCreationRequest(String tableName, String hashKeyName) {
        return new CreateTableRequest()
                .withTableName(tableName)
                .withAttributeDefinitions(createAttributeDefinitions(hashKeyName))
                .withKeySchema(createKeySchema(hashKeyName))
                .withProvisionedThroughput(new ProvisionedThroughput(READ_CAPACITY, WRITE_CAPACITY));
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
