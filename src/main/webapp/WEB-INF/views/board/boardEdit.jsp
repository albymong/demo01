<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 수정 | Modern Board</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">
    <style>
        :root {
            --primary-color: #4f46e5;
            --primary-hover: #4338ca;
            --bg-color: #f3f4f6;
            --card-bg: #ffffff;
            --text-main: #1f2937;
            --text-muted: #6b7280;
            --border-color: #e5e7eb;
        }

        body { 
            font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, 'Helvetica Neue', 'Segoe UI', 'Apple System', sans-serif;
            background-color: var(--bg-color); 
            color: var(--text-main);
            padding-top: 40px;
            padding-bottom: 40px;
        }

        .main-container {
            max-width: 700px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .btn-secondary-custom {
            background-color: #fff;
            color: var(--text-muted);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 8px 16px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.2s;
        }

        .btn-secondary-custom:hover {
            background-color: #f9fafb;
            color: var(--text-main);
        }

        .edit-card {
            background: var(--card-bg);
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border-color);
            overflow: hidden;
        }

        .edit-header {
            padding: 24px 32px;
            border-bottom: 1px solid var(--border-color);
            background-color: #fff;
        }

        .edit-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-main);
            margin: 0;
            letter-spacing: -0.02em;
        }

        .edit-body {
            padding: 32px;
        }

        .form-label {
            font-weight: 600;
            color: var(--text-muted);
            font-size: 0.85rem;
            margin-bottom: 6px;
            display: block;
        }

        .form-control {
            border-radius: 10px;
            border: 1px solid var(--border-color);
            padding: 12px;
            transition: border-color 0.2s, box-shadow 0.2s;
            margin-bottom: 20px;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
            outline: none;
        }

        .attachment-info {
            background-color: #f9fafb;
            padding: 16px;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            margin-bottom: 20px;
        }

        .attachment-label {
            font-weight: 700;
            font-size: 0.85rem;
            color: var(--text-muted);
            margin-bottom: 10px;
            display: block;
        }

        .file-chip {
            display: inline-flex;
            align-items: center;
            padding: 4px 10px;
            background: #fff;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            margin-right: 6px;
            margin-bottom: 6px;
            font-size: 0.8rem;
            color: var(--text-main);
        }

        .btn-save {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 12px 24px;
            font-weight: 600;
            transition: all 0.2s;
        }

        .btn-save:hover {
            background-color: var(--primary-hover);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3);
        }

        .btn-cancel {
            background-color: #fff;
            color: var(--text-muted);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 12px 24px;
            font-weight: 600;
            transition: all 0.2s;
        }

        .btn-cancel:hover {
            background-color: #f9fafb;
            color: var(--text-main);
        }
    </style>
</head>
<body>
<div class="main-container">
    <div class="page-header">
        <a href="/board/view/<%= request.getAttribute("postId") %>" class="btn-secondary-custom">← 상세보기</a>
    </div>

    <div class="edit-card">
        <div class="edit-header">
            <h4 class="edit-title">게시글 수정</h4>
        </div>
        <div class="edit-body">
            <input type="hidden" id="postId">
            
            <div class="mb-3">
                <label class="form-label">작성자</label>
                <input type="text" class="form-control" id="postAuthor" placeholder="작성자 이름을 입력하세요">
            </div>
            <div class="mb-3">
                <label class="form-label">제목</label>
                <input type="text" class="form-control" id="postTitle" placeholder="제목을 입력하세요">
            </div>
            <div class="mb-3">
                <label class="form-label">내용</label>
                <textarea class="form-control" id="postContent" rows="10" placeholder="내용을 작성해 주세요"></textarea>
            </div>
            
            <div class="attachment-info">
                <span class="attachment-label">현재 첨부파일</span>
                <div id="currentFiles" class="d-flex flex-wrap">
                    <!-- 파일 칩들이 여기 추가됨 -->
                </div>
            </div>
            
            <div class="mb-4">
                <label class="form-label">새 첨부파일 추가 (최대 10개, 각 최대 10MB)</label>
                <input type="file" class="form-control" id="newFiles" multiple>
            </div>
            
            <div class="d-flex justify-content-end gap-2">
                <button class="btn btn-cancel" onclick="window.history.back()">취소</button>
                <button class="btn btn-save" onclick="updatePost()">저장하기</button>
            </div>
        </div>
    </div>
</div>

<script>
var postId = null;
var currentPost = null;

function loadPost() {
    var path = window.location.pathname;
    postId = path.split('/').pop();
    
    $.ajax({
        url: '/api/board/posts/' + postId,
        method: 'GET',
        success: function(data) {
            currentPost = data.post;
            $('#postId').val(currentPost.id);
            $('#postAuthor').val(currentPost.author || '');
            $('#postTitle').val(currentPost.title || '');
            $('#postContent').val(currentPost.content || '');
            
            var attachments = currentPost.attachments || [];
            var fileList = $('#currentFiles');
            if (attachments.length === 0) {
                fileList.html('<span class="text-muted" style="font-size: 0.85rem;">첨부파일이 없습니다.</span>');
            } else {
                fileList.empty();
                attachments.forEach(function(filename) {
                    fileList.append('<span class="file-chip">' + filename + '</span>');
                });
            }
        },
        error: function() {
            alert('게시글을 불러올 수 없습니다.');
            window.location.href = '/board';
        }
    });
}

function updatePost() {
    var author = $('#postAuthor').val().trim();
    var title = $('#postTitle').val().trim();
    var content = $('#postContent').val().trim();
    var newFiles = $('#newFiles')[0].files;
    
    if (!author || !title || !content) {
        alert('모든 항목을 입력해 주세요.');
        return;
    }
    
    if (newFiles.length > 10) {
        alert('최대 10개까지 업로드 가능합니다.');
        return;
    }
    
    var formData = new FormData();
    formData.append('author', author);
    formData.append('title', title);
    formData.append('content', content);
    for (var i = 0; i < newFiles.length; i++) {
        formData.append('files', newFiles[i]);
    }
    
    $.ajax({
        url: '/api/board/posts/' + postId + '/edit',
        method: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            if (response.success) {
                alert('수정되었습니다.');
                window.location.href = '/board/view/' + postId;
            } else {
                alert(response.message || '수정 실패');
            }
        },
        error: function(xhr) {
            alert('수정 중 오류가 발생했습니다: ' + xhr.responseText);
        }
    });
}

document.addEventListener('DOMContentLoaded', loadPost);
</script>
</body>
</html>