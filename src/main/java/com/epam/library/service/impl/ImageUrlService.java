package com.epam.library.service.impl;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

@Service
class ImageUrlService {
    // TODO: 20. 08. 24. log error, if not set
    //     @Autowired
    //     private Environment environment;
    @Value("${staticContent.imageUrlPrefix}")
    private String imageUrlPrefix;

    String prefix(String url) {
        return UrlService.normalizeUrlOrDefaultTo(imageUrlPrefix + url);
    }
}
