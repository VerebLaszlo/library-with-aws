package com.epam.library.service.impl;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

@Service
class ImageUrlService {
    private static final String IMG_URL_INFIX = "img";

    private final UrlService urlService;

    // TODO: 20. 08. 24. log error, if not set
    @Value("${staticContent.imageUrlPrefix}")
    private String imageUrlPrefix;

    ImageUrlService(UrlService urlService) {
        this.urlService = urlService;
    }

    String prefix(String imageUrl) {
        return urlService.normalizeUrl(imageUrlPrefix, IMG_URL_INFIX, imageUrl).orElse(imageUrl);
    }
}
