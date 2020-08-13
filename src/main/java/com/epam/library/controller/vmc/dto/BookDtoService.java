package com.epam.library.controller.vmc.dto;

import com.epam.library.model.*;
import com.epam.library.service.*;

import org.jetbrains.annotations.*;

import org.springframework.stereotype.*;

import java.util.*;

import static java.util.stream.Collectors.*;

@Service
public class BookDtoService {
    private final BookFacade bookFacade;

    public BookDtoService(BookFacade bookFacade) {
        this.bookFacade = bookFacade;
    }

    public List<BookDto> getBooks() {
        return convert(bookFacade.getBooks());
    }

    private static List<BookDto> convert(@NotNull Collection<? extends Book> books) {
        return books.stream().map(BookDtoService::convert).collect(toList());
    }

    @NotNull
    private static BookDto convert(Book book) {
        return new BookDto(book.getTitle(), book.getAuthor(), book.getPublisher(), book.getIsbn(), book.getCoverUrl());
    }
}
