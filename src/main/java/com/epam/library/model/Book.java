package com.epam.library.model;

import java.util.*;

public class Book {
    private final Isbn isbn;
    private final String title;
    private final String author;
    private final String publisher;

    private Book() {
        isbn = new Isbn("");
        title = "";
        author = "";
        publisher = "";
    }

    public Book(String title, String author, String publisher, Isbn isbn) {
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.isbn = isbn;
    }

    public Book copyWithIsdn(Isbn newIsbn) {
        return new Book(title, author, publisher, newIsbn);
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
        return String.format("Book{title='%s', author='%s', publisher='%s', isbn=%s}", title, author, publisher, isbn);
    }
}
