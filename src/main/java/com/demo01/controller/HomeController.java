package com.demo01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * 홈 페이지 컨트롤러
 * root URL ("/") 요청을 index.jsp 로 포워드합니다.
 */
@Controller
public class HomeController {

    @GetMapping("/")
    public String index() {
        // /index.jsp 파일은 webapp 루트에 위치합니다.
        // viewResolver가 /WEB-INF/views/를 기준으로 하기 때문에
        // 직접 forward 를 사용하여 JSP를 제공합니다.
        return "forward:/index.jsp";
    }
}
