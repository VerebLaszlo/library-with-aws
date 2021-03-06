package com.epam.library.controller.rest;

import com.epam.library.model.*;
import com.epam.library.service.*;

import org.slf4j.*;

import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/v1/books")
class BookRestController {
    private static final Logger LOG = LoggerFactory.getLogger(BookRestController.class);
    private final BookFacade bookFacade;

    BookRestController(BookFacade bookFacade) {
        this.bookFacade = bookFacade;
    }

    @GetMapping
    public final List<Book> getBooks() {
        return bookFacade.getBooks();
    }

    @PostMapping
    public final ResponseEntity<Book> create(@RequestBody Book book) {
        try {
            return ResponseEntity.ok(bookFacade.save(book));
        } catch (IllegalArgumentException e) {
            LOG.error("Could not create book.", e);
            return ResponseEntity.badRequest().build();
        }
    }
}
