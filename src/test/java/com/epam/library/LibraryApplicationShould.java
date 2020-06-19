package com.epam.library;

import com.epam.library.service.BookService.*;
import com.epam.library.util.*;

import org.junit.jupiter.api.*;

import org.springframework.boot.test.context.*;
import org.springframework.boot.test.mock.mockito.*;

import static org.assertj.core.api.Assertions.*;

@SpringBootTest
@DisplayNameGeneration(CamelCaseDisplayNameGenerator.class)
class LibraryApplicationShould {
    @MockBean
    private BookRepository repository;

    @Test
    void loadContextWhenStarts() {
        assertThat(true).as("Context was not loaded.").isTrue();
    }
}
