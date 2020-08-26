package com.epam.library;

import com.epam.library.model.*;

import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.module.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.context.annotation.*;
import org.springframework.http.converter.*;
import org.springframework.http.converter.json.*;
import org.springframework.web.servlet.config.annotation.*;

import java.util.*;

@EnableWebMvc
@Configuration
public class WebConfiguration implements WebMvcConfigurer {

    @Autowired
    private ObjectMapper objectMapper;

    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        MappingJackson2HttpMessageConverter messageConverter = new MappingJackson2HttpMessageConverter();
        objectMapper.registerModule(new SimpleModule().addDeserializer(Isbn.class, new IsbnDeserializer())
                                                      .addSerializer(Isbn.class, new IsbnSerializer()));
        messageConverter.setObjectMapper(objectMapper);
        converters.add(messageConverter);
    }
}
