package com.demo01.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * 파일 업로드 유틸리티
 * 
 * [설명]
 * - MultipartFile을 받아 지정된 디렉토리에 저장합니다.
 * - 파일 이름 충돌을 방지하기 위해 UUID를 앞에 붙입니다.
 * - 최대 10개까지 업로드할 수 있습니다.
 */
public class FileUploadUtil {

    private static final String UPLOAD_DIR = "D:/uploads/board";
    private static final int MAX_FILES = 10;
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB

    /**
     * 여러 파일 업로드
     * 
     * @param files MultipartFile 배열
     * @return 저장된 파일名的 목록
     */
    public static List<String> uploadFiles(MultipartFile[] files) throws IOException {
        List<String> fileNames = new ArrayList<>();
        
        if (files == null || files.length == 0) {
            return fileNames;
        }
        
        // 최대 개수 체크
        if (files.length > MAX_FILES) {
            throw new IOException("최대 " + MAX_FILES + "개까지 업로드 가능합니다.");
        }
        
        // 디렉토리 생성
        File uploadDir = new File(UPLOAD_DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        for (MultipartFile file : files) {
            if (file != null && !file.isEmpty()) {
                // 파일 크기 체크
                if (file.getSize() > MAX_FILE_SIZE) {
                    throw new IOException("파일 크기는 10MB를 초과할 수 없습니다: " + file.getOriginalFilename());
                }
                
                // 원본 파일명
                String originalFilename = file.getOriginalFilename();
                // 확장자 추출
                String extension = "";
                if (originalFilename.contains(".")) {
                    extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                
                // UUID + 원본 파일명으로 저장
                String newFilename = UUID.randomUUID().toString() + "_" + System.currentTimeMillis() + extension;
                
                // 파일 저장
                Path filePath = Paths.get(UPLOAD_DIR, newFilename);
                Files.write(filePath, file.getBytes());
                
                fileNames.add(newFilename);
            }
        }
        
        return fileNames;
    }

    /**
     * 파일 삭제
     */
    public static boolean deleteFile(String filename) {
        try {
            Path filePath = Paths.get(UPLOAD_DIR, filename);
            return Files.deleteIfExists(filePath);
        } catch (IOException e) {
            return false;
        }
    }
}