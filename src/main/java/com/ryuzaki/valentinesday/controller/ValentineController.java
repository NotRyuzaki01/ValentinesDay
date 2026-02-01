package com.ryuzaki.valentinesday.controller;

import com.ryuzaki.valentinesday.service.ValentineService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class ValentineController {
    private final ValentineService valentineService;

    public ValentineController(ValentineService valentineService) {
        this.valentineService = valentineService;
    }

    @GetMapping("/")
    public String home() {
        return "index";
    }

    @PostMapping("/index/yes")
    public String yes(){
        valentineService.acceptValentine();
        return "result";
    }
}
