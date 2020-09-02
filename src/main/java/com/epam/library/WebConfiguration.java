package com.epam.library;

import com.epam.library.model.*;

import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.module.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.context.annotation.*;
import org.springframework.http.converter.*;
import org.springframework.http.converter.json.*;
import org.springframework.web.servlet.*;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.view.*;

import java.util.*;

@EnableWebMvc
@Configuration
class WebConfiguration implements WebMvcConfigurer {

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

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/img/**").addResourceLocations("/WEB-INF/static/img/");
        registry.addResourceHandler("/css/**").addResourceLocations("/WEB-INF/static/css/");
        registry.addResourceHandler("/js/**").addResourceLocations("/WEB-INF/static/js/");
    }

    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver bean = new InternalResourceViewResolver();
        bean.setViewClass(JstlView.class);
        bean.setPrefix("/WEB-INF/jsp/");
        bean.setSuffix(".jsp");
        return bean;
    }
}
