package com.epam.library.repository.dynamo;

import com.epam.library.model.*;
import com.epam.library.service.*;

import com.amazonaws.services.dynamodbv2.*;
import com.amazonaws.services.dynamodbv2.datamodeling.*;
import org.slf4j.*;

import org.springframework.stereotype.*;

import java.util.*;

import static java.util.Collections.*;
import static org.slf4j.LoggerFactory.*;

@Repository
public class BookRepositoryImpl implements BookRepository {
    private static final Logger LOG = getLogger(BookRepositoryImpl.class);

    private final Converter converter;
    private final DynamoDBMapper mapper;

    BookRepositoryImpl(AmazonDynamoDB client, Converter converter) {
        this.converter = converter;
        mapper = new DynamoDBMapper(client);
    }

    @Override
    public List<Book> getBooks() {
        try {
            return converter.convert(new ArrayList<>(mapper.scan(BookModel.class, new DynamoDBScanExpression())));
        } catch (RuntimeException e) {
            LOG.error("Could not get books from DB.", e);
            return emptyList();
        }
    }

    @Override
    public Book save(Book book) {
        BookModel bookModel = converter.convert(book);
        mapper.save(bookModel);
        return converter.convert(bookModel);
    }
}
