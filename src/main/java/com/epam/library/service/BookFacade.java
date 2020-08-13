package com.epam.library.service;

import com.epam.library.model.*;

import java.util.*;

public interface BookFacade {
    List<Book> getBooks();

    Book save(Book book);
}
