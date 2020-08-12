package com.epam.library.controller;

import com.epam.library.model.*;

import org.junit.jupiter.api.*;

import org.springframework.http.*;

import static com.epam.library.util.LibraryAssertions.then;
import static java.util.Collections.*;
import static org.mockito.BDDMockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

class GivenControllerAndLibraryWithoutBooks extends GivenControllerAndLibrary {

    @BeforeEach
    final void beforeEach() {
        given(repository.getBooks()).willReturn(emptyList());
    }

    @Test
    void listingBooks_should_returnEmptyList() throws Exception {
        var actual = mvc.perform(get(BOOKS_REST_API).contentType(MediaType.APPLICATION_JSON))
                        .andReturn();

        then(actual).hasOkStatus()
                    .hasBody("[]");
    }

    @Test
    void creatingABook_returnsInternalServerError_if_repositoryFails() throws Exception {
        given(repository.save(any(Book.class)))
                .willThrow(RuntimeException.class);

        var actual = mvc.perform(post(BOOKS_REST_API).contentType(MediaType.APPLICATION_JSON)
                                                     .content(INPUTTED_BOOK_JSON))
                        .andReturn();

        then(actual).hasInternalServerErrorStatus()
                    .hasBody("");
    }

    @Test
    void creatingABook_returnsTheCreatedBook() throws Exception {
        given(repository.save(any(Book.class)))
                .willReturn(newBookStub);

        var actual = mvc.perform(post(BOOKS_REST_API).contentType(MediaType.APPLICATION_JSON)
                                                     .content(INPUTTED_BOOK_JSON))
                        .andReturn();

        then(actual).hasOkStatus()
                    .hasBody(EXPECTED_NEW_BOOK_JSON);
    }
}
