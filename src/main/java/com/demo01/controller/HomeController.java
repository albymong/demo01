package com.demo01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * 홈 페이지 컨트롤러
 * 
 * [설명]
 * - 이 컨트롤러는 웹사이트의 첫 화면(홈페이지)을 담당합니다.
 * - 사용자가 웹 브라우저에서 사이트를 처음 방문했을 때
 *   이 컨트롤러가 index.jsp 파일을 보여줍니다.
 * - '/' (루트) 주소로 접근하면 이 메서드가 실행됩니다.
 * 
 * [주요 기능]
 * - GET /: 首页 페이지 (index.jsp)を表示
 * 
 * [처리 과정]
 * 1. 사용자가 웹 브라우저에서 http://localhost:8080/ (또는 http://localhost:8080) 접근
 * 2. DispatcherServlet이 요청을 받아 HomeController로 전달
 * 3. @GetMapping("/")이 적용된 index() 메서드 실행
 * 4. "forward:/index.jsp"를 반환하여 index.jsp 파일로 이동 (포워드 방식)
 *    (포워드는 서버 내부에서 다른 페이지로 이동하는 것, URL은 바뀌지 않음)
 * 5. 사용자에게 index.jsp의 내용이 표시됨
 */
@Controller  // 이 클래스가 Spring MVC의 컨트롤러임을 나타내는 어노테이션
public class HomeController {

    /**
     *首页 페이지로 이동합니다.
     * 
     * [주소]
     * - GET /
     * 
     * [동작 방식]
     * - 이 메서드는 "forward:/index.jsp"를 반환합니다.
     * - forward는 현재 요청을 다른 JSP 파일로 전달하는 것입니다.
     * - 이를 통해 src/main/webapp/index.jsp 파일이 화면에 표시됩니다.
     * 
     * @return index.jsp 파일로 포워드 (서버 내부에서 이동)
     */
    @GetMapping("/")  // GET 방식의 루트 요청을 이 메서드가 처리
    public String index() {
        // /index.jsp 파일은 src/main/webapp 폴더에 있습니다.
        // viewResolver가 /WEB-INF/views/를 기준으로 하지만
        // forward를 사용하면 원하는 JSP 파일을 직접 지정할 수 있습니다.
        return "forward:/index.jsp";
    }
}
