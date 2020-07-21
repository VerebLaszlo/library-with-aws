package com.epam.library.repository.dynamo;

import com.epam.library.model.*;

import org.jetbrains.annotations.*;

import org.springframework.stereotype.*;

import java.util.*;
import java.util.stream.*;

@Component
class Converter {
    public List<Book> convert(@NotNull Iterable<? extends BookModel> all) {
        return StreamSupport.stream(all.spliterator(), false)
                            .map(this::convert)
                            .collect(Collectors.toList());
    }

    public Book convert(@NotNull BookModel bookModel) {
        return new Book(bookModel.getTitle(),
                        bookModel.getAuthor(),
                        bookModel.getPublisher(),
                        new Isbn(bookModel.getIsbn()),
                        bookModel.getId()
        );
    }

    public BookModel convert(@NotNull Book book) {
        return new BookModel(book.getId().orElse(null),
                             book.getTitle(),
                             book.getAuthor(),
                             book.getPublisher(),
                             book.getIsbn()
        );
    }
}
