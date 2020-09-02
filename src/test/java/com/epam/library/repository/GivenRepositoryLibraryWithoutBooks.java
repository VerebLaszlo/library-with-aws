package com.epam.library.repository;

import com.epam.library.model.*;
import com.epam.library.service.*;
import com.epam.library.util.*;

import org.junit.jupiter.api.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.test.annotation.*;

import static com.epam.library.util.LibraryAssertions.*;
import static org.assertj.core.api.BDDAssumptions.*;

@IntegrationTest
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
@DisplayNameGeneration(CamelCaseDisplayNameGenerator.class)
class GivenRepositoryLibraryWithoutBooks {

    private static final Book BOOK_STUB = Book.builder(new Isbn("Isdb"), "Title", "Author", "Publisher", "/book-0.png")
                                              .build();
    @Autowired
    private BookRepository repository;

    @Test
    void listingBooks_should_returnEmptyList() {
        var result = repository.getBooks();

        then(result).isEmpty();
    }

    @Test
    void savingANewBook_should_returnTheCreatedBook() {
        given(BOOK_STUB.getId()).isEmpty();

        var result = repository.save(BOOK_STUB);

        then(result).isEqualTo(BOOK_STUB);
        then(result).hasId();
    }
}

