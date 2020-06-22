package com.epam.library.util;

import com.epam.library.model.*;

import org.assertj.core.api.*;

import org.springframework.test.web.servlet.*;

public class LibraryAssertions extends BDDAssertions {
    public static MvcResultAssert<MvcResult> then(MvcResult actual) {
        return new MvcResultAssert<>(actual);
    }

    public static BookAssert<Book> then(Book actual) {
        return new BookAssert<>(actual);
    }

    public static <T> ObjectAssert<T> then(T actual) {
        return BDDAssertions.then(actual);
    }
}
