package com.epam.library.service.impl;

import org.slf4j.*;

import java.net.*;

import static org.slf4j.LoggerFactory.*;

public class UrlService {
    private static final Logger LOG = getLogger(UrlService.class);

    public static String normalizeUrlOrDefaultTo(String url) {
        try {
            return new URI(url).normalize().toString();
        } catch (URISyntaxException e) {
            LOG.error("Wrong URL format.", e);
        }
        return url;
    }
}
