package com.epam.library.service.impl;

import com.epam.library.model.*;
import com.epam.library.service.*;

import org.springframework.stereotype.*;

import java.util.*;

@Service
class BookService {
    private final BookRepository bookRepository;

    BookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    final List<Book> getBooks() {
        return bookRepository.getBooks();
    }

    Book save(Book book) {
        return bookRepository.save(book);
    }
}
