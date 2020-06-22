package com.epam.library.repository.dynamo;

import com.epam.library.model.*;
import com.epam.library.service.BookService.*;

import com.amazonaws.services.dynamodbv2.*;
import com.amazonaws.services.dynamodbv2.datamodeling.*;

import org.springframework.stereotype.*;

import java.util.*;

@Repository
public class BookRepositoryImpl implements BookRepository {
    private final Converter converter;
    private final DynamoDBMapper mapper;

    BookRepositoryImpl(AmazonDynamoDB client, Converter converter) {
        this.converter = converter;
        mapper = new DynamoDBMapper(client);
    }

    @Override
    public List<Book> getBooks() {
        return converter.convert(new ArrayList<>(mapper.scan(BookModel.class, new DynamoDBScanExpression())));
    }

    @Override
    public Book save(Book book) {
        BookModel bookModel = converter.convert(book);
        mapper.save(bookModel);
        return converter.convert(bookModel);
    }
}
