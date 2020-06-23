package com.epam.library.repository;

import com.epam.library.model.*;
import com.epam.library.service.BookService.*;
import com.epam.library.util.*;

import org.junit.jupiter.api.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.boot.test.context.*;
import org.springframework.context.annotation.*;
import org.springframework.test.annotation.*;

import static com.epam.library.util.LibraryAssertions.*;
import static org.assertj.core.api.BDDAssumptions.*;

@SpringBootTest
@Import(LibraryWithBooksConfiguration.class)
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
@DisplayNameGeneration(CamelCaseDisplayNameGenerator.class)
class GivenLibraryWithBooks {
    private static final Book BOOK_STUB = new Book("Title", "Author", "Publisher", new Isbn("Isdb"));
    @Autowired
    private BookRepository repository;

    @Test
    void listingBooks_should_returnBooks() {
        var result = repository.getBooks();

        then(result).hasSize(LibraryWithBooksConfiguration.NUMBER_OF_BOOKS);
    }

    @Test
    void savingABook_should_returnTheSavedBook() {
        given(BOOK_STUB.getId()).isEmpty();

        var result = repository.save(BOOK_STUB);

        then(result).isEqualTo(BOOK_STUB);
        then(result).hasId();
    }
}

