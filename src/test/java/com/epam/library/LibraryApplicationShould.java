package com.epam.library;

import com.epam.library.service.BookService.*;
import com.epam.library.util.*;

import org.junit.jupiter.api.*;

import org.springframework.boot.test.mock.mockito.*;

import static org.assertj.core.api.Assertions.*;

@IntegrationTest
@DisplayNameGeneration(CamelCaseDisplayNameGenerator.class)
class LibraryApplicationShould {
    private static final boolean CONTEXT_LOADED = true;
    @MockBean
    private BookRepository repository;

    @Test
    void loadContextWhenStarts() {
        assertThat(CONTEXT_LOADED).as("Context was not loaded.").isTrue();
    }
}
