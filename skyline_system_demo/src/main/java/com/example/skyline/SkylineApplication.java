package com.example.skyline;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping; // <--- import 추가
import org.springframework.stereotype.Controller; // <--- import 추가

@SpringBootApplication
@Controller // <--- 1. 어노테이션 추가
public class SkylineApplication {
    public static void main(String[] args) {
        SpringApplication.run(SkylineApplication.class, args);
    }

    // 2. SPA Fallback 라우팅 메소드 추가
    @RequestMapping(value = {"/", "/{path:[^\\.]*}"})
    public String forward() {
        return "forward:/index.html";
    }
}
