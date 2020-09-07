package com.epam.library.controller.vmc;

import com.epam.library.controller.vmc.dto.*;
import com.epam.library.service.*;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;


@Controller
@RequestMapping("/books")
class BookController {
    private static final String VIEW_NAME = "booksDetails";
    private static final String MODEL_NAME = "books";
    private static final String REGION = "awsRegion";

    private final BookDtoService bookService;
    private final UtilityService utilityService;

    BookController(BookDtoService bookService, UtilityService utilityService) {
        this.bookService = bookService;
        this.utilityService = utilityService;
    }

    @GetMapping
    public final ModelAndView getBooks() {
        var modelAndView = new ModelAndView(VIEW_NAME);
        modelAndView.addObject(REGION, utilityService.getRegion());
        modelAndView.addObject(MODEL_NAME, bookService.getBooks());
        return modelAndView;
    }
}
