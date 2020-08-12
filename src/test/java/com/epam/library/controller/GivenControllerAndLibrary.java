package com.epam.library.controller;

import com.epam.library.model.*;
import com.epam.library.service.*;
import com.epam.library.util.*;

import org.junit.jupiter.api.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.boot.test.autoconfigure.web.servlet.*;
import org.springframework.boot.test.mock.mockito.*;
import org.springframework.http.*;
import org.springframework.test.web.servlet.*;

import static com.epam.library.util.LibraryAssertions.then;
import static org.mockito.BDDMockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

@IntegrationTest
@AutoConfigureMockMvc
@DisplayNameGeneration(CamelCaseDisplayNameGenerator.class)
class GivenControllerAndLibrary {
    static final String BOOKS_REST_API = "/api/v1/books";

    static final Book newBookStub = new Book(new Isbn("New ISBN"), "New Title", "New Author", "New Publisher",
                                             "/book-0.png");

    static final String INPUTTED_BOOK_JSON
            = "{\"isbn\":{\"number\":\"ISBN\"},\"title\":\"Title\",\"author\":\"Author\",\"publisher\":\"Publisher\",\"coverUrl\":\"/book-0.png\"}";
    static final String EXPECTED_NEW_BOOK_JSON
            = "{\"id\":null,\"isbn\":\"New ISBN\",\"title\":\"New Title\",\"author\":\"New Author\","
              + "\"publisher\":\"New Publisher\",\"coverUrl\":\"/book-0.png\"}";

    @Autowired
    protected MockMvc mvc;

    @MockBean
    protected BookService.BookRepository repository;

    @Test
    void listingBooks_should_returnInternalServerError_if_repositoryFails() throws Exception {
        given(repository.getBooks())
                .willThrow(RuntimeException.class);

        var actual = mvc.perform(get(BOOKS_REST_API).contentType(MediaType.APPLICATION_JSON))
                        .andReturn();

        then(actual).hasInternalServerErrorStatus()
                    .hasBody("");
    }
}
