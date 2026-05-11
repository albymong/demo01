<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유게시판 | Modern Board</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://unpkg.com/gridjs/dist/theme/mermaid.min.css" rel="stylesheet" />
    <script src="https://unpkg.com/gridjs/dist/gridjs.production.min.js"></script>
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
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .board-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .board-title {
            font-size: 1.8rem;
            font-weight: 800;
            color: var(--text-main);
            letter-spacing: -0.02em;
        }

        .board-title span {
            color: var(--primary-color);
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            border-radius: 10px;
            padding: 10px 20px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3);
        }

        /* Grid.js Modern Styling */
        .gridjs-wrapper { 
            background: var(--card-bg); 
            padding: 20px; 
            border-radius: 16px; 
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border-color);
        }

        .gridjs-table {
            font-size: 0.95rem;
        }

        .gridjs-th {
            background-color: #f9fafb !important;
            color: var(--text-muted) !important;
            font-weight: 600 !important;
            text-transform: uppercase;
            font-size: 0.8rem !important;
            border-bottom: 2px solid var(--border-color) !important;
        }

        .gridjs-td {
            padding: 12px 15px !important;
        }

        .gridjs-td a {
            color: var(--text-main);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s;
        }

        .gridjs-td a:hover {
            color: var(--primary-color);
            text-decoration: underline;
        }

        /* Modal Styling */
        .modal-content {
            border: none;
            border-radius: 20px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
        }

        .modal-header {
            border-bottom: 1px solid var(--border-color);
            padding: 20px 24px;
            border-top-left-radius: 20px;
            border-top-right-radius: 20px;
        }

        .modal-title {
            font-weight: 700;
            color: var(--text-main);
        }

        .modal-body {
            padding: 24px;
        }

        .form-label {
            font-weight: 600;
            color: var(--text-muted);
            font-size: 0.85rem;
            margin-bottom: 6px;
        }

        .form-control {
            border-radius: 10px;
            border: 1px solid var(--border-color);
            padding: 12px;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        .modal-footer {
            border-top: 1px solid var(--border-color);
            padding: 16px 24px;
            border-bottom-left-radius: 20px;
            border-bottom-right-radius: 20px;
        }
    </style>
</head>
<body>
<div class="main-container">
    <div class="board-header">
        <h2 class="board-title">📋 <span>자유</span>게시판</h2>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#writeModal">새 글쓰기</button>
    </div>

    <div id="grid-container"></div>
</div>

<!-- 글쓰기 모달 -->
<div class="modal fade" id="writeModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">새 글 작성하기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label">작성자</label>
                    <input type="text" class="form-control" id="postAuthor" placeholder="이름을 입력하세요">
                </div>
                <div class="mb-3">
                    <label class="form-label">제목</label>
                    <input type="text" class="form-control" id="postTitle" placeholder="제목을 입력하세요">
                </div>
                <div class="mb-3">
                    <label class="form-label">내용</label>
                    <textarea class="form-control" id="postContent" rows="5" placeholder="내용을 작성해 주세요"></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">첨부파일 (최대 10개, 각 최대 10MB)</label>
                    <input type="file" class="form-control" id="postFiles" multiple accept="*/*">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" onclick="savePost()">저장하기</button>
            </div>
        </div>
    </div>
</div>

<script>
var grid;

function formatDate(createdAt) {
    if (!createdAt) return 'N/A';
    try {
        if (typeof createdAt === 'string') {
            return createdAt.replace('T', ' ');
        } else if (createdAt.year) {
            return createdAt.year + '-' + 
                   String(createdAt.monthValue || 0).padStart(2,'0') + '-' + 
                   String(createdAt.dayOfMonth || 0).padStart(2,'0') + ' ' + 
                   String(createdAt.hour || 0).padStart(2,'0') + ':' + 
                   String(createdAt.minute || 0).padStart(2,'0');
        }
    } catch (e) {
        console.error('날짜 변환 오류:', e);
    }
    return 'N/A';
}

function cleanData(data) {
    if (!data || !Array.isArray(data)) return [];
    var total = data.length;
    return data.map(function(post, index) {
        return {
            seq: total - index, // 최신글이 가장 큰 번호를 갖는 순번
            id: post.id,
            title: post.title || '제목 없음',
            author: post.author || '익명',
            createdAt: formatDate(post.createdAt)
        };
    });
}

function loadBoardData() {
    $.ajax({
        url: '/api/board/posts',
        method: 'GET',
        dataType: 'json',
        success: function(data) {
            var cleanedPosts = cleanData(data);
            
            if (grid) {
                grid.updateConfig({
                    data: cleanedPosts
                }).forceRender();
            } else {
                grid = new gridjs.Grid({
                    columns: [
                        { id: 'seq', name: '번호', width: '80px' },
                        { id: 'id', name: 'ID', hidden: true },
                        { 
                            id: 'title', 
                            name: '제목', 
                            formatter: (cell, row) => {
                                // hidden column인 id(index 1) 값을 가져와 링크 생성
                                var postId = row.cells[1].data;
                                return gridjs.html(`<a href="/board/view/${postId}" style="color: var(--text-main); text-decoration: none; font-weight: 500;">${cell}</a>`);
                            }
                        },
                        { id: 'author', name: '작성자', width: '150px' },
                        { id: 'createdAt', name: '작성일', width: '200px' }
                    ],
                    data: cleanedPosts,
                    search: true,
                    pagination: { limit: 10 },
                    sort: true,
                    language: {
                        'search': { 'placeholder': '검색어를 입력하세요...' },
                        'pagination': {
                            'previous': '이전',
                            'next': '다음',
                            'showing': '표시 중',
                            'to': '까지',
                            'of': '전체'
                        }
                    }
                }).render(document.getElementById('grid-container'));
            }
        },
        error: function(xhr, status, error) {
            console.error('API 호출 에러:', status, error);
            document.getElementById('grid-container').innerHTML = '<div class="alert alert-danger">데이터를 불러오는 중 오류가 발생했습니다.</div>';
        }
    });
}

function savePost() {
    var author = document.getElementById('postAuthor').value.trim();
    var title = document.getElementById('postTitle').value.trim();
    var content = document.getElementById('postContent').value.trim();
    var fileInput = document.getElementById('postFiles');
    var files = fileInput.files;
    
    if (!author || !title || !content) {
        alert('모든 항목을 입력해 주세요.');
        return;
    }
    
    if (files.length > 10) {
        alert('최대 10개까지 업로드 가능합니다.');
        return;
    }
    
    var formData = new FormData();
    formData.append('author', author);
    formData.append('title', title);
    formData.append('content', content);
    for (var i = 0; i < files.length; i++) {
        formData.append('files', files[i]);
    }
    
    $.ajax({
        url: '/api/board/posts/upload',
        method: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            if (response.success) {
                alert('저장되었습니다.');
                var modal = bootstrap.Modal.getInstance(document.getElementById('writeModal'));
                modal.hide();
                document.getElementById('postAuthor').value = '';
                document.getElementById('postTitle').value = '';
                document.getElementById('postContent').value = '';
                document.getElementById('postFiles').value = '';
                loadBoardData();
            } else {
                alert(response.message || '저장 중 오류가 발생했습니다.');
            }
        },
        error: function(xhr) {
            alert('저장 중 오류가 발생했습니다: ' + xhr.responseText);
        }
    });
}

document.addEventListener('DOMContentLoaded', loadBoardData);
</script>
</body>
</html>