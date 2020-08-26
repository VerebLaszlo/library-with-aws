package com.epam.library.model;

import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import org.jetbrains.annotations.*;

import org.springframework.boot.jackson.*;

import java.io.*;

@JsonComponent
public class IsbnDeserializer extends JsonDeserializer<Isbn> {
    @Override
    @Nullable
    public final Isbn deserialize(JsonParser p, DeserializationContext context) throws IOException {
        String isbnAsText = p.getText();
        return isbnAsText == null ? null : new Isbn(isbnAsText);
    }

    @Override
    public Class<?> handledType() {
        return Isbn.class;
    }
}
