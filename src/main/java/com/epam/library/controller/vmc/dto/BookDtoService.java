package com.epam.library.controller.vmc.dto;

import com.epam.library.model.*;
import com.epam.library.service.*;

import org.jetbrains.annotations.*;

import org.springframework.stereotype.*;

import java.util.*;

import static java.util.stream.Collectors.*;

@Service
public class BookDtoService {
    private final BookService bookService;

    public BookDtoService(BookService bookService) {
        this.bookService = bookService;
    }

    public List<BookDto> getBooks() {
        return convert(bookService.getBooks());
    }

    private List<BookDto> convert(@NotNull Collection<? extends Book> books) {
        return books.stream().map(this::convert).collect(toList());
    }

    @NotNull
    private BookDto convert(Book book) {
        return new BookDto(book.getTitle(), book.getAuthor(), book.getPublisher(), book.getIsbn(), book.getCoverUrl());
    }
}
