package com.epam.library.model;

import org.jetbrains.annotations.*;

import java.util.*;

public final class Book {
    private final @Nullable String id;
    private final Isbn isbn;
    private final String title;
    private final String author;
    private final String publisher;
    private final String coverUrl;

    private Book(Isbn isbn, String title, String author, String publisher, String coverUrl, @Nullable String id) {
        this.isbn = isbn;
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.coverUrl = coverUrl;
        this.id = id;
    }

    public static Book.Builder builder(Isbn isbn, String title, String author, String publisher, String coverUrl) {
        return new Builder(isbn, title, author, publisher, coverUrl);
    }

    @NotNull
    public Book copyWithUrl(String coverUrl) {
        return new Book(isbn, title, author, publisher, coverUrl, id);
    }

    public Isbn getIsbn() {
        return isbn;
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

    public String getCoverUrl() {
        return coverUrl;
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
        return String.format("Book{id='%s', isbn=%s, title='%s', author='%s', publisher='%s', coverUrl='%s'}",
                             id, isbn, title, author, publisher, coverUrl);
    }

    public static final class Builder {
        private final Isbn isbn;
        private final String title;
        private final String author;
        private final String publisher;
        private final String coverUrl;
        private @Nullable String id;

        private Builder(Isbn isbn, String title, String author, String publisher, String coverUrl) {
            this.isbn = isbn;
            this.title = title;
            this.author = author;
            this.publisher = publisher;
            this.coverUrl = coverUrl;
        }

        public Builder withId(@Nullable String id) {
            this.id = id;
            return this;
        }

        public Book build() {
            return new Book(isbn, title, author, publisher, coverUrl, id);
        }
    }
}
