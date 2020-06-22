package com.epam.library.util;

import com.epam.library.model.*;

import org.assertj.core.api.*;

public class BookAssert<T> extends AbstractAssert<BookAssert<Book>, Book> {

    public BookAssert(Book actual) {
        super(actual, BookAssert.class);
    }

    public BookAssert<T> hasId() {
        if (actual.getId().isEmpty())
            failWithMessage("Expected the 'id' to be present, but was missing.");
        return this;
    }
}
