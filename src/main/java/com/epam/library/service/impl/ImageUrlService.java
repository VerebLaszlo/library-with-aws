package com.epam.library.service.impl;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

@Service
class ImageUrlService {
    @Value("${staticContent.imageUrlPrefix}")
    private String imageUrlPrefix;

    String prefix(String url) {
        return UrlService.normalizeUrlOrDefaultTo(imageUrlPrefix + url);
    }
}
