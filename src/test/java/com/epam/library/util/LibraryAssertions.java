package com.epam.library.util;

import org.assertj.core.api.*;

import org.springframework.test.web.servlet.*;

public class LibraryAssertions extends BDDAssertions {
    public static MvcResultAssert<MvcResult> then(MvcResult actual) {
        return new MvcResultAssert<>(actual);
    }
}
