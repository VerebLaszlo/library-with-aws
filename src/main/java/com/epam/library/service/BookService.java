package com.epam.library.service;

import com.epam.library.model.*;

import java.util.*;

public interface BookService {
    List<Book> getBooks();

    Book save(Book book);

    interface BookRepository {
        List<Book> getBooks();

        Book save(Book book);
    }
}
