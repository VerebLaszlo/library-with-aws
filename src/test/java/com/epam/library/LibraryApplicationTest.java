package com.epam.library;

import com.epam.library.util.*;
import org.junit.jupiter.api.*;
import org.springframework.boot.test.context.*;

import static org.assertj.core.api.Assertions.*;

@SpringBootTest
@DisplayNameGeneration(CamelCaseDisplayNameGenerator.class)
class LibraryApplicationTest {
    @Test
    void loadContextWhenStarts() {
        assertThat(true).as("Context was not loaded.").isTrue();
    }
}
