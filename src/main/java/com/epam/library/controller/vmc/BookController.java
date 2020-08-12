package com.epam.library.controller.vmc;

import com.epam.library.controller.vmc.dto.*;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

@Controller
@RequestMapping("/books")
public class BookController {
    private static final String VIEW_NAME = "booksDetails";
    private static final String MODEL_NAME = "books";

    private final BookDtoService bookService;

    BookController(BookDtoService bookService) {
        this.bookService = bookService;
    }

    @GetMapping
    public final ModelAndView getBooks() {
        var modelAndView = new ModelAndView(VIEW_NAME);
        modelAndView.addObject(MODEL_NAME, bookService.getBooks());
        return modelAndView;
    }
}
