package com.epam.library.service.impl;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import static java.lang.String.*;

@Service
class ImageUrlService {
    private final UrlService urlService;

    // TODO: 20. 08. 24. log error, if not set
    @Value("${staticContent.imageUrlPrefix}")
    private String imageUrlPrefix;

    ImageUrlService(UrlService urlService) {
        this.urlService = urlService;
    }

    String prefix(String url) {
        return urlService.normalizeUrlOrDefaultTo(format("%s%s", imageUrlPrefix, url));
    }
}
