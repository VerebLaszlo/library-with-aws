package com.epam.library.service.impl;

import com.epam.library.model.*;
import com.epam.library.service.*;

import org.springframework.stereotype.*;

import java.util.*;

@Service
public class BookServiceImpl implements BookService {
    private final BookRepository bookRepository;

    public BookServiceImpl(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    @Override
    public final List<Book> getBooks() {
        return bookRepository.getBooks();
    }

    @Override
    public Book create(Book book) {
        return bookRepository.create(book);
    }
}
