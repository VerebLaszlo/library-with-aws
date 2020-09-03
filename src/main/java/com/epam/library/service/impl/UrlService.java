package com.epam.library.service.impl;

import org.slf4j.*;

import org.springframework.stereotype.*;

import java.net.*;
import java.util.*;

import static org.slf4j.LoggerFactory.*;

@Service
class UrlService {
    private static final Logger LOG = getLogger(UrlService.class);

    Optional<String> normalizeUrl(String ...urlComponents) {
        String urlString = String.join("/", urlComponents);
        try {
            return Optional.of(new URI(urlString).normalize().toString());
        } catch (URISyntaxException e) {
            LOG.error("Wrong URL format.", e);
        }
        return Optional.empty();
    }
}
