package com.epam.library.service.impl;

import com.epam.library.model.*;
import com.epam.library.service.*;

import org.springframework.stereotype.*;

import java.util.*;

import static java.util.stream.Collectors.*;

@Service
public class BookFacadeImpl implements BookFacade {
    private final BookService bookService;
    private final ImageUrlService imageUrlService;

    public BookFacadeImpl(BookService bookService, ImageUrlService imageUrlService) {
        this.bookService = bookService;
        this.imageUrlService = imageUrlService;
    }

    @Override
    public List<Book> getBooks() {
        return bookService.getBooks().stream()
                          .map(book -> book.withUrl(imageUrlService.prefix(book.getCoverUrl())))
                          .collect(toList());
    }

    @Override
    public Book save(Book book) {
        return bookService.save(book);
    }
}
