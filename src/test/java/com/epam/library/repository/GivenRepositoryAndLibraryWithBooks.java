package com.epam.library.repository;

import com.epam.library.model.*;
import com.epam.library.service.*;
import com.epam.library.util.*;

import org.junit.jupiter.api.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.context.annotation.*;
import org.springframework.test.annotation.*;

import static com.epam.library.util.LibraryAssertions.*;
import static org.assertj.core.api.BDDAssumptions.*;

@IntegrationTest
@Import(LibraryRepositoryContentConfiguration.class)
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
@DisplayNameGeneration(CamelCaseDisplayNameGenerator.class)
class GivenRepositoryAndLibraryWithBooks {


    private static final Book BOOK_STUB = new Book(new Isbn("Isdb"), "Title", "Author", "Publisher", "/book-0.png");
    @Autowired
    private BookRepository repository;

    @Test
    void listingBooks_should_returnBooks() {
        var result = repository.getBooks();

        then(result).hasSize(LibraryRepositoryContentConfiguration.NUMBER_OF_BOOKS);
    }

    @Test
    void savingABook_should_returnTheSavedBook() {
        given(BOOK_STUB.getId()).isEmpty();

        var result = repository.save(BOOK_STUB);

        then(result).isEqualTo(BOOK_STUB);
        then(result).hasId();
    }
}

