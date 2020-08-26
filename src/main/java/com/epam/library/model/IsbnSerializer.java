package com.epam.library.model;

import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import org.jetbrains.annotations.*;

import org.springframework.boot.jackson.*;

import java.io.*;

@JsonComponent
public class IsbnSerializer extends JsonSerializer<Isbn> {
    @Override
    public final void serialize(@NotNull Isbn value, @NotNull JsonGenerator gen, SerializerProvider serializers)
            throws IOException {
        gen.writeObject(value.getNumber());
    }

    @Override
    public Class<Isbn> handledType() {
        return Isbn.class;
    }
}
