package com.epam.library.controller;

import com.epam.library.model.*;
import com.epam.library.service.*;

import org.slf4j.*;

import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/v1/books")
class BookController {
    private static final Logger LOG = LoggerFactory.getLogger(BookController.class);
    private final BookService bookService;

    BookController(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping
    public final List<Book> getBooks() {
        return bookService.getBooks();
    }

    @PostMapping
    public final ResponseEntity<Book> create(@RequestBody Book book) {
        try {
            return ResponseEntity.ok(bookService.save(book));
        } catch (IllegalArgumentException e) {
            LOG.error("Could not create book.", e);
            return ResponseEntity.badRequest().build();
        }
    }
}
