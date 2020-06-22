package com.epam.library;

import org.slf4j.*;

import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.*;
import org.springframework.context.*;

@SuppressWarnings({"NonFinalUtilityClass", "UtilityClassCanBeEnum"})
@SpringBootApplication
class LibraryApplication {
    private static final Logger LOG = LoggerFactory.getLogger(LibraryApplication.class);
    private static final String LIBRARY_IS_UP = "Library is up.";
    private static final String LIBRARY_IS_DOWN = "Library is down.";

    public static void main(String[] args) {
        try (ConfigurableApplicationContext context = SpringApplication.run(LibraryApplication.class, args)) {
            LOG.info(getSimpleRunningMessage(context));
        }
    }

    private static String getSimpleRunningMessage(Lifecycle context) {
        return context.isRunning() ? LIBRARY_IS_UP : LIBRARY_IS_DOWN;
    }
}
