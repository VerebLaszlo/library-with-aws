package com.epam.library.controller.vmc.dto;

import com.epam.library.model.*;

public class BookDto {
    private final String title;
    private final String author;
    private final String publisher;
    private final String isbn;
    private final String coverUrl;

    BookDto(String title, String author, String publisher, Isbn isbn, String coverUrl) {
        this.isbn = isbn.getNumber();
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.coverUrl = coverUrl;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public String getPublisher() {
        return publisher;
    }

    public String getIsbn() {
        return isbn;
    }

    public String getCoverUrl() {
        return coverUrl;
    }

    @Override
    public String toString() {
        return String.format("BookDto{title='%s', author='%s', publisher='%s', isbn='%s', coverUrl='%s'}",
                             title, author, publisher, isbn, coverUrl);
    }
}
