package com.ryuzaki.valentinesday.service;

import org.springframework.stereotype.Service;

@Service
public class ValentineServiceImpl implements ValentineService {
    @Override
    public void acceptValentine() {
        System.out.println("Valentine accepted ❤\uFE0F");
    }
}
