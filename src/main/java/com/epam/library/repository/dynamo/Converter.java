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

    Book convert(@NotNull BookModel bookModel) {
        return new Book(new Isbn(bookModel.getIsbn()),
                        bookModel.getTitle(),
                        bookModel.getAuthor(),
                        bookModel.getPublisher(),
                        bookModel.getCoverUrl(),
                        bookModel.getId()
        );
    }

    BookModel convert(@NotNull Book book) {
        return new BookModel(book.getId().orElse(null),
                             book.getIsbn(),
                             book.getTitle(),
                             book.getAuthor(),
                             book.getPublisher(),
                             book.getCoverUrl()
        );
    }
}
