package com.epam.library.repository.dynamo;

import com.epam.library.model.*;

import org.jetbrains.annotations.*;

import org.springframework.stereotype.*;

import java.util.*;
import java.util.stream.*;

@Component
class Converter {
    List<Book> convert(@NotNull Iterable<? extends BookModel> all) {
        return StreamSupport.stream(all.spliterator(), false)
                            .map(this::convert)
                            .collect(Collectors.toList());
    }

    Book convert(@NotNull BookModel book) {
        return Book.builder(new Isbn(book.getIsbn()),
                            book.getTitle(),
                            book.getAuthor(),
                            book.getPublisher(),
                            book.getCoverUrl())
                   .withId(book.getId()).build();
    }

    BookModel convert(@NotNull Book book) {
        return BookModel.builder(book.getIsbn().getNumber(),
                                 book.getTitle(),
                                 book.getAuthor(),
                                 book.getPublisher(),
                                 book.getCoverUrl())
                        .withId(book.getId().orElse(null)).build();
    }
}
