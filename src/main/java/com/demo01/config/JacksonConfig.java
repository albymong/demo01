package com.demo01.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

/**
 * Jackson JSON 설정
 * 
 * [설명]
 * - Jackson이 Java 8 날짜/시간 타입(LocalDateTime 등)을 JSON으로 변환할 수 있도록 설정합니다.
 * - 이 클래스는 Spring이 자동으로 Bean으로 등록하여 JSON 변환 시 사용됩니다.
 */
@Configuration
public class JacksonConfig {

    /**
     * ObjectMapper Bean 생성
     * - JavaTimeModule을 등록하여 LocalDateTime을 지원합니다.
     * - NULL 값은 JSON에 포함하지 않도록 설정합니다.
     */
    @Bean
    @Primary
    public ObjectMapper objectMapper() {
        ObjectMapper mapper = new ObjectMapper();
        
        // Java 8 날짜/시간 모듈 등록
        mapper.registerModule(new JavaTimeModule());
        
        // 날짜를 ISO-8601 문자열로 출력
        mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        
        return mapper;
    }
}