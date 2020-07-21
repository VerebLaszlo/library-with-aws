package com.epam.library.util;

import java.lang.annotation.*;

@Retention(RetentionPolicy.CLASS)
public @interface Justification {
    String value();
}
