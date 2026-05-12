package com.demo01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * 자유게시판 UI 제공 컨트롤러
 * 
 * [설명]
 * - 이 컨트롤러는 '자유게시판' 화면을 보여주기 위한 역할을 합니다.
 * - 웹 브라우저에서 '/board' 라는 주소를 입력하면
 *   이 메서드가 실행되어 게시판 화면을 보여줍니다.
 * - Spring MVC에서 'Controller' 어노테이션을 붙이면
 *   웹 요청을 처리하는 핸들러로 등록됩니다.
 * 
 * [주요 기능]
 * - GET /board: 게시판 메인 페이지 표시
 *   (나중에 글 작성, 수정, 삭제 등의 기능도 여기에 추가할 예정입니다)
 * 
 * [처리 과정]
 * 1. 사용자가 웹 브라우저에서 '/board' 주소 입력
 * 2. DispatcherServlet이 이 요청을 받아 BoardController로 전달
 * 3. @GetMapping("/board")가 적용된 board() 메서드 실행
 * 4. "board/board" 라는 view 이름 반환
 * 5. ViewResolver가 /WEB-INF/views/board/board.jsp 파일을 찾아 화면 표시
 */
@Controller  // 이 클래스가 Spring MVC의 컨트롤러임을 나타내는 어노테이션
public class BoardController {

    /**
     * 자유게시판 메인 페이지を表示합니다.
     * 
     * [주소]
     * - GET /board
     * 
     * [동작 방식]
     * 1. 웹 브라우저에서 http://localhost:8080/board 요청
     * 2. 이 메서드가 호출되어 "board/board" 라는 view 이름 반환
     * 3. view resolver가 JSP 파일을 찾아 사용자에게 화면을 보여줍니다
     * 
     * @return 게시판 JSP 파일의 경로 (board/board -> /WEB-INF/views/board/board.jsp)
     */
    @GetMapping("/board")  // GET 방식의 /board 요청을 이 메서드가 처리
    public String board() {
        // view resolver가 /WEB-INF/views/ 폴더를 기준으로 board/board.jsp를 찾음
        return "board/board"; 
    }
    
    @GetMapping("/board/view/{id}")
    public String boardView() {
        return "board/boardDetail";
    }
    
    @GetMapping("/board/edit/{id}")
    public String boardEdit() {
        return "board/boardEdit";
    }
}
