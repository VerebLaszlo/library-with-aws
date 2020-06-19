package com.epam.library.model;

import java.util.*;

public final class Isbn {
    private final String number;

    private Isbn() {
        number = "";
    }

    public Isbn(String number) {
        this.number = number;
    }

    public String getNumber() {
        return number;
    }

    @Override
    public int hashCode() {
        return Objects.hash(number);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Isbn isbn = (Isbn) obj;
        return number.equals(isbn.number);
    }

    @Override
    public String toString() {
        return String.format("Isbn{number='%s'}", number);
    }
}
