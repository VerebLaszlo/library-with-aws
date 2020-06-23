package com.epam.library.repository;

import com.epam.library.repository.dynamo.*;

import com.amazonaws.services.dynamodbv2.*;
import com.amazonaws.services.dynamodbv2.datamodeling.*;
import org.jetbrains.annotations.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.boot.test.context.*;
import org.springframework.context.annotation.*;

import javax.annotation.*;
import java.util.*;
import java.util.stream.*;

@TestConfiguration
@Import(LibraryConfiguration.class)
class LibraryWithBooksConfiguration {
    static final int NUMBER_OF_BOOKS = 5;

    @Autowired
    private AmazonDynamoDB amazonDynamoDB;

    @PostConstruct
    void test() {
        new DynamoDBMapper(amazonDynamoDB).batchSave(generateBooks(NUMBER_OF_BOOKS));
    }

    @NotNull
    private List<BookModel> generateBooks(int numberOfBooksInLibrary) {
        return IntStream.range(0, numberOfBooksInLibrary)
                        .mapToObj(i -> new BookModel(null,
                                                     "Title " + i,
                                                     "Author " + i,
                                                     "Publisher " + i,
                                                     "Isbn" + i))
                        .collect(Collectors.toList());
    }
}
