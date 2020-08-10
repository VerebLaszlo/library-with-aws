package com.epam.library.controller;

import com.epam.library.model.*;

import org.junit.jupiter.api.*;

import org.springframework.http.*;

import java.util.*;

import static com.epam.library.util.LibraryAssertions.then;
import static org.mockito.BDDMockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

class GivenLibraryWithBooks extends GivenLibrary {
    private static final Book BOOK_STUB = new Book("Title", "Author", "Publisher", new Isbn("ISBN"));
    private static final String EXPECTED_BOOKS_IN_LIBRARY
            = "[{\"id\":null,\"isbn\":\"ISBN\",\"title\":\"Title\",\"author\":\"Author\",\"publisher\":\"Publisher\"}"
            + ",{\"id\":null,\"isbn\":\"a\",\"title\":\"Title\",\"author\":\"Author\",\"publisher\":\"Publisher\"}"
            + ",{\"id\":null,\"isbn\":\"b\",\"title\":\"Title\",\"author\":\"Author\",\"publisher\":\"Publisher\"}]";

    @BeforeEach
    final void beforeEach() {
        given(repository.getBooks())
                .willReturn(List.of(BOOK_STUB, withIsbn(BOOK_STUB, "a"), withIsbn(BOOK_STUB, "b")));
    }

    @Test
    void listingBooks_should_returnBooks() throws Exception {
        var actual = mvc.perform(get(BOOKS_REST_API).contentType(MediaType.APPLICATION_JSON))
                        .andReturn();

        then(actual).hasOkStatus()
                    .hasBody(EXPECTED_BOOKS_IN_LIBRARY);
    }

    @Test
    void creatingANewBook_should_returnTheCreatedBook() throws Exception {
        given(repository.save(any(Book.class)))
                .willReturn(newBookStub);

        var actual = mvc.perform(post(BOOKS_REST_API)
                                         .contentType(MediaType.APPLICATION_JSON)
                                         .content(INPUTTED_BOOK_JSON))
                        .andReturn();

        verify(repository).save(any(Book.class));
        then(actual).hasOkStatus()
                    .hasBody(EXPECTED_NEW_BOOK_JSON);
    }

    @Test
    void creatingABookAlreadyInLibrary_should_fail() throws Exception {
        given(repository.save(any(Book.class)))
                .willThrow(IllegalArgumentException.class);

        var actual = mvc.perform(post(BOOKS_REST_API)
                                         .contentType(MediaType.APPLICATION_JSON)
                                         .content(INPUTTED_BOOK_JSON))
                        .andReturn();

        verify(repository).save(any(Book.class));
        then(actual).hasBadRequestStatus()
                    .hasBody("");
    }

    //region helper functions
    static Book withIsbn(Book bookStub, String isbn) {
        return new Book(bookStub.getTitle(), bookStub.getAuthor(), bookStub.getPublisher(), new Isbn(isbn));
    }
    //endregion
}
