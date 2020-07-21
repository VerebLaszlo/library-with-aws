package com.epam.library;

import com.epam.library.util.*;

import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.*;

@SuppressWarnings({"NonFinalUtilityClass", "UtilityClassCanBeEnum"})
@Justification("Required spring non utility class.")
@SpringBootApplication
public class LibraryTestApplication {
    public static void main(String[] args) {
        // WARN: Do not use with try-with-resource block
        SpringApplication.run(LibraryApplication.class, args);
    }
}
