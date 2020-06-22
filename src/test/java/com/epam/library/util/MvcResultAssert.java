package com.epam.library.util;

import org.assertj.core.api.*;
import org.jetbrains.annotations.*;

import org.springframework.http.*;
import org.springframework.mock.web.*;
import org.springframework.test.web.servlet.*;

import java.io.*;

import static java.lang.String.*;

public class MvcResultAssert<T> extends AbstractAssert<MvcResultAssert<MvcResult>, MvcResult> {

    private static final int INITIAL_PADDING_LENGTH = AssertionError.class.getName().length() + "Expected the".length();

    MvcResultAssert(MvcResult actual) {
        super(actual, MvcResultAssert.class);
    }

    public MvcResultAssert<T> hasOkStatus() {
        MockHttpServletResponse response = actual.getResponse();
        failWithMessage("status", HttpStatus.OK, HttpStatus.valueOf(response.getStatus()));
        return this;
    }

    private void failWithMessage(String content, HttpStatus expectedValue, HttpStatus actualValue) {
        if (expectedValue != actualValue)
            failWithMessage(format("Expected the %s to be '%s', but was '%s'.", content, expectedValue, actualValue));
    }

    public MvcResultAssert<T> hasBadRequestStatus() {
        MockHttpServletResponse response = actual.getResponse();
        failWithMessage("status", HttpStatus.BAD_REQUEST, HttpStatus.valueOf(response.getStatus()));
        return this;
    }

    public MvcResultAssert<T> hasInternalServerErrorStatus() {
        MockHttpServletResponse response = actual.getResponse();
        failWithMessage("status", HttpStatus.INTERNAL_SERVER_ERROR, HttpStatus.valueOf(response.getStatus()));
        return this;
    }

    public MvcResultAssert<T> hasBody(String expected) throws UnsupportedEncodingException {
        MockHttpServletResponse response = actual.getResponse();
        failWithMessage("body", expected, response.getContentAsString());
        return this;
    }

    //region helper methods
    private <V> void failWithMessage(String content, @NotNull V expectedValue, V actualValue) {
        if (!expectedValue.equals(actualValue))
            failWithMessage(formatted(content, expectedValue, actualValue));
    }

    private static <V> String formatted(String content, @NotNull V expectedValue, V actualValue) {
        return format("Expected the %s to be '%s',%n %s but was '%s'.",
                      content, expectedValue, getPadding(content), actualValue);
    }

    @NotNull
    private static String getPadding(@NotNull CharSequence content) {
        return " ".repeat(content.length() + INITIAL_PADDING_LENGTH);
    }
    //endregion
}
