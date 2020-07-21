package com.epam.library.util;

import com.epam.library.*;

import org.springframework.boot.test.context.*;
import org.springframework.core.annotation.*;
import org.springframework.test.context.*;

import java.lang.annotation.*;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
@Inherited
@SpringBootTest(classes = LibraryTestApplication.class)
@ActiveProfiles
public @interface IntegrationTest {
    @AliasFor(annotation = ActiveProfiles.class, attribute = "profiles") String[] activeProfiles() default {"test"};
}
