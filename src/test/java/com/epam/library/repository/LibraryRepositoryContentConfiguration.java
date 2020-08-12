package com.epam.library.repository;

import com.epam.library.repository.dynamo.*;

import com.amazonaws.services.dynamodbv2.*;
import com.amazonaws.services.dynamodbv2.datamodeling.*;
import org.jetbrains.annotations.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.boot.test.context.*;

import javax.annotation.*;
import java.util.*;
import java.util.stream.*;

@TestConfiguration
class LibraryRepositoryContentConfiguration {
    static final int NUMBER_OF_BOOKS = 5;

    @Autowired
    private AmazonDynamoDB amazonDynamoDB;

    @PostConstruct
    void populateDB() {
        new DynamoDBMapper(amazonDynamoDB).batchSave(generateBooks());
    }

    @NotNull
    private static List<BookModel> generateBooks() {
        return IntStream.range(0, NUMBER_OF_BOOKS)
                        .mapToObj(i -> new BookModel(null,
                                                     "Title " + i,
                                                     "Author " + i,
                                                     "Publisher " + i,
                                                     "Isbn " + i))
                        .collect(Collectors.toList());
    }
}
