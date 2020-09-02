package com.epam.library.controller;

import com.epam.library.model.*;

import org.junit.jupiter.api.*;

import org.springframework.http.*;

import java.util.*;

import static com.epam.library.util.LibraryAssertions.then;
import static org.mockito.BDDMockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

class GivenControllerAndLibraryWithBooks extends GivenControllerAndLibrary {
    private static final Book BOOK_STUB = Book.builder(new Isbn("ISBN"), "Title", "Author", "Publisher", "/book-0.png")
                                              .build();
    private static final String EXPECTED_BOOKS_IN_LIBRARY
            = "[{\"id\":null,\"isbn\":\"ISBN\",\"title\":\"Title\",\"author\":\"Author\",\"publisher\":\"Publisher\""
              + ",\"coverUrl\":\"img/book-0.png\"}"
              + ",{\"id\":null,\"isbn\":\"a\",\"title\":\"Title\",\"author\":\"Author\",\"publisher\":\"Publisher\""
              + ",\"coverUrl\":\"img/book-0.png\"}"
              + ",{\"id\":null,\"isbn\":\"b\",\"title\":\"Title\",\"author\":\"Author\",\"publisher\":\"Publisher\","
              + "\"coverUrl\":\"img/book-0.png\"}]";

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
        return Book.builder(new Isbn(isbn),
                            bookStub.getTitle(),
                            bookStub.getAuthor(),
                            bookStub.getPublisher(),
                            bookStub.getCoverUrl()).build();
    }
    //endregion
}
