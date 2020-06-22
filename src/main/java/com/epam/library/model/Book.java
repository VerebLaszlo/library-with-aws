package com.epam.library.model;

import org.jetbrains.annotations.*;

import java.util.*;

public class Book {
    private final @Nullable String id;
    private final Isbn isbn;
    private final String title;
    private final String author;
    private final String publisher;

    private Book() {
        this("", "", "", new Isbn(""));
    }

    public Book(String title, String author, String publisher, Isbn isbn) {
        this(title, author, publisher, isbn, null);
    }

    public Book(String title, String author, String publisher, Isbn isbn, @Nullable String id) {
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.isbn = isbn;
        this.id = id;
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

    public Isbn getIsbn() {
        return isbn;
    }

    public Optional<@Nullable String> getId() {
        return Optional.ofNullable(id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(title, author, publisher, isbn);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Book book = (Book) obj;
        return title.equals(book.title) &&
               author.equals(book.author) &&
               publisher.equals(book.publisher) &&
               isbn.equals(book.isbn);
    }

    @Override
    public String toString() {
        return String.format("Book{id='%s', isbn=%s, title='%s', author='%s', publisher='%s'}",
                             id, isbn, title, author, publisher);
    }
}
