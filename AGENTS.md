# AGENTS.md – 레포지토리 운영 가이드

## 📌 목표
- 에이전트가 이 Maven 기반 Spring MVC 웹앱을 빠르게 설정·실행하도록 핵심 정보를 제공한다.
- 에이전트가 놓치기 쉬운 설정·명령어만 남기고, 일반적인 Java/Spring 설명은 제외한다.

---

## 1️⃣ 프로젝트 구조
- `src/main/webapp` – 웹 애플리케이션 루트. `index.jsp` 가 여기 위치한다.
- `src/main/webapp/WEB-INF/dispatcher-servlet.xml` – Spring MVC 설정. `component-scan` 은 `com.demo01` 패키지를 스캔한다.
- `src/main/java/com/demo01/controller` – 컨트롤러 구현 위치 (`HomeController`).
- `src/main/resources/application.properties` – `PropertySourcesPlaceholderConfigurer` 가 로드하는 필수 파일 (비어도 존재해야 함).
- `pom.xml` – `war` 패키징, `spring-webmvc`·`spring-context` 의존성 포함.

---

## 2️⃣ 필수 명령어
| 목적 | 명령어 | 비고 |
|------|--------|------|
| 의존성·빌드 | `mvn clean package` | `target/demo01.war` 가 생성됨 |
| 로컬 Tomcat 실행 | `mvn tomcat7:run` *(Tomcat 플러그인 추가 시)* | 기본 포트 8080, `/` 경로는 `index.jsp` 로 포워드됨 |
| 테스트 실행 | `mvn test` | 현재 JUnit 3.8 사용 |
| 전체 청소 | `mvn clean` | `target/` 디렉터리 삭제 |

> **주의**: `application.properties` 파일이 없으면 컨텍스트 초기화가 실패한다 (`BeanInitializationException`). 반드시 프로젝트 루트 `src/main/resources` 에 존재해야 한다.

---

## 3️⃣ 웹 접근 흐름
1. `web.xml` 에서 `DispatcherServlet` 이 `/` 로 매핑됨.
2. `dispatcher-servlet.xml` 에서 `InternalResourceViewResolver` 가 `/WEB-INF/views/` 를 기본 프리픽스·`.jsp` 서픽스 로 설정한다.
3. `HomeController` 의 `@GetMapping("/")` 가 `forward:/index.jsp` 를 반환해 루트 요청을 `src/main/webapp/index.jsp` 로 포워드한다.

---

## 4️⃣ 흔히 놓치는 점
- **프로퍼티 파일**: 빈 파일이라도 `src/main/resources/application.properties` 가 존재해야 컨텍스트가 정상 초기화된다.
- **패키지 스캔**: `dispatcher-servlet.xml` 의 `component-scan` 은 `com.demo01` 로 제한돼 있다. 컨트롤러는 반드시 이 패키지(또는 하위)에 있어야 한다.
- **WAR 배포**: `mvn package` 로 만든 `.war` 를 외부 Tomcat에 배포할 경우 `WEB-INF/web.xml` 과 `dispatcher-servlet.xml` 위치가 유지돼야 한다.

---

## 5️⃣ 참고 파일
- `pom.xml` – Maven 설정 및 의존성.
- `src/main/webapp/WEB-INF/web.xml` – 서블릿·필터 정의.
- `src/main/webapp/WEB-INF/dispatcher-servlet.xml` – Spring 설정.
- `src/main/webapp/index.jsp` – 기본 페이지.
- `src/main/resources/application.properties` – 필수 빈 프로퍼티 파일.

---

*이 파일은 에이전트가 레포지토리를 빠르게 파악하고, 초기화·실행 중 흔히 발생하는 오류를 방지하도록 설계되었습니다.*