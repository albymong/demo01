<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 상세보기 | Modern Board</title>
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
            max-width: 900px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .btn-secondary {
            background-color: #fff;
            color: var(--text-muted);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.2s;
        }

        .btn-secondary:hover {
            background-color: #f9fafb;
            color: var(--text-main);
        }

        .post-card {
            background: var(--card-bg);
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border-color);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .post-header {
            padding: 32px 32px 24px;
            border-bottom: 1px solid var(--border-color);
        }

        .post-title {
            font-size: 1.75rem;
            font-weight: 800;
            color: var(--text-main);
            margin-bottom: 12px;
            letter-spacing: -0.02em;
        }

        .post-meta {
            font-size: 0.9rem;
            color: var(--text-muted);
            display: flex;
            gap: 16px;
        }

        .post-body {
            padding: 32px;
            font-size: 1.05rem;
            line-height: 1.7;
            color: #374151;
            white-space: pre-wrap;
        }

        .attachment-section {
            padding: 24px 32px;
            background-color: #f9fafb;
            border-top: 1px solid var(--border-color);
        }

        .attachment-label {
            font-weight: 700;
            font-size: 0.9rem;
            color: var(--text-muted);
            margin-bottom: 12px;
            display: block;
        }

        .attachment-item {
            display: inline-flex;
            align-items: center;
            padding: 6px 12px;
            background: #fff;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            margin-right: 8px;
            margin-bottom: 8px;
            text-decoration: none;
            color: var(--text-main);
            font-size: 0.85rem;
            transition: all 0.2s;
        }

        .attachment-item:hover {
            border-color: var(--primary-color);
            color: var(--primary-color);
            background: rgba(79, 70, 229, 0.05);
        }

        /* Comments Section */
        .comments-container {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 32px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border-color);
        }

        .comments-title {
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .comment-item {
            padding: 16px 0;
            border-bottom: 1px solid var(--border-color);
            transition: background 0.2s;
        }

        .comment-item:last-child {
            border-bottom: none;
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 8px;
        }

        .comment-author {
            font-weight: 600;
            font-size: 0.95rem;
            color: var(--text-main);
        }

        .comment-date {
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        .comment-text {
            font-size: 0.95rem;
            color: #4b5563;
            margin-bottom: 8px;
        }

        .btn-delete-comment {
            font-size: 0.75rem;
            color: #ef4444;
            text-decoration: none;
            font-weight: 500;
        }

        .comment-form {
            margin-top: 32px;
            padding-top: 24px;
            border-top: 2px solid var(--bg-color);
        }

        .comment-input-group {
            display: flex;
            gap: 12px;
            margin-bottom: 12px;
        }

        .comment-author-input {
            width: 150px;
            border-radius: 10px;
            border: 1px solid var(--border-color);
            padding: 10px;
        }

        .comment-textarea {
            border-radius: 10px;
            border: 1px solid var(--border-color);
            padding: 12px;
            resize: none;
        }

        .btn-submit-comment {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 10px 24px;
            font-weight: 600;
            float: right;
            transition: background 0.2s;
        }

        .btn-submit-comment:hover {
            background-color: var(--primary-hover);
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 24px;
            margin-bottom: 40px;
        }

        .btn-edit {
            background-color: #fef3c7;
            color: #92400e;
            border: 1px solid #fde68a;
            border-radius: 10px;
            padding: 8px 16px;
            font-weight: 600;
            transition: all 0.2s;
        }

        .btn-edit:hover {
            background-color: #fde68a;
        }

        .btn-delete {
            background-color: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
            border-radius: 10px;
            padding: 8px 16px;
            font-weight: 600;
            transition: all 0.2s;
        }

        .btn-delete:hover {
            background-color: #fecaca;
        }
    </style>
</head>
<body>
<div class="main-container">
    <div class="page-header">
        <a href="/board" class="btn btn-secondary">← 목록으로 돌아가기</a>
    </div>

    <div class="post-card">
        <div class="post-header">
            <h4 class="post-title" id="postTitle">제목을 불러오는 중...</h4>
            <div class="post-meta">
                <span><strong>작성자:</strong> <span id="postAuthor">...</span></span>
                <span><strong>작성일:</strong> <span id="postCreatedAt">...</span></span>
            </div>
        </div>
        <div class="post-body" id="postContent">
            내용을 불러오는 중입니다...
        </div>
        <div class="attachment-section">
            <span class="attachment-label">📎 첨부파일</span>
            <div id="attachmentList"></div>
        </div>
    </div>

    <div class="action-buttons">
        <button class="btn btn-edit" onclick="editPost()">수정하기</button>
        <button class="btn btn-delete" onclick="deletePost()">삭제하기</button>
    </div>

    <div class="comments-container">
        <h5 class="comments-title">💬 댓글 <span id="commentCount" class="badge bg-secondary ms-2">0</span></h5>
        <div id="commentList">
            <p class="text-muted text-center py-4">댓글을 불러오는 중입니다...</p>
        </div>
        
        <div class="comment-form">
            <div class="comment-input-group">
                <input type="text" class="form-control comment-author-input" id="commentAuthor" placeholder="작성자">
                <input type="text" class="form-control" id="commentContent" placeholder="댓글 내용을 입력하세요...">
                <button class="btn btn-submit-comment" onclick="saveComment()">등록</button>
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
            showPost(data.post);
            showComments(data.comments);
        },
        error: function() {
            alert('게시글을 불러올 수 없습니다.');
            window.location.href = '/board';
        }
    });
}

function showPost(post) {
    $('#postTitle').text(post.title || '제목 없음');
    $('#postAuthor').text(post.author || '익명');
    $('#postContent').text(post.content || '내용이 없습니다.');
    
    var dateStr = '';
    if (post.createdAt) {
        if (typeof post.createdAt === 'string') {
            dateStr = post.createdAt.replace('T', ' ');
        } else if (post.createdAt.year) {
            dateStr = post.createdAt.year + '-' + 
                     String(post.createdAt.monthValue).padStart(2,'0') + '-' + 
                     String(post.createdAt.dayOfMonth).padStart(2,'0') + ' ' + 
                     String(post.createdAt.hour).padStart(2,'0') + ':' + 
                     String(post.createdAt.minute).padStart(2,'0');
        }
    }
    $('#postCreatedAt').text(dateStr || 'N/A');
    
    var attachments = post.attachments || [];
    var attachList = $('#attachmentList');
    if (attachments.length === 0) {
        attachList.html('<span class="text-muted" style="font-size: 0.85rem;">첨부파일이 없습니다.</span>');
    } else {
        attachList.empty();
        attachments.forEach(function(filename) {
            var ext = filename.split('.').pop().toLowerCase();
            var isImage = ['jpg','jpeg','png','gif','webp'].includes(ext);
            var url = '/api/board/files/' + encodeURIComponent(filename);
            
            if (isImage) {
                attachList.append(`<a href="${url}" target="_blank" class="attachment-item">
                    <img src="${url}" style="width:20px; height:20px; margin-right:8px; border-radius:4px; object-fit:cover;">
                    ${filename}
                </a>`);
            } else {
                attachList.append(`<a href="${url}" target="_blank" class="attachment-item">📄 ${filename}</a>`);
            }
        });
    }
}

function showComments(comments) {
    var list = $('#commentList');
    list.empty();
    $('#commentCount').text(comments.length);
    
    if (comments.length === 0) {
        list.html('<p class="text-muted text-center py-4">첫 번째 댓글을 남겨보세요!</p>');
        return;
    }
    
    comments.forEach(function(c) {
        var dateStr = '';
        if (c.createdAt) {
            if (typeof c.createdAt === 'string') {
                dateStr = c.createdAt.substring(0, 16).replace('T', ' ');
            } else if (c.createdAt.year) {
                dateStr = c.createdAt.year + '-' + 
                         String(c.createdAt.monthValue).padStart(2,'0') + '-' + 
                         String(c.createdAt.dayOfMonth).padStart(2,'0') + ' ' + 
                         String(c.createdAt.hour).padStart(2,'0') + ':' + 
                         String(c.createdAt.minute).padStart(2,'0');
            }
        }
        
        var div = $('<div class="comment-item"></div>');
        div.html(`
            <div class="comment-header">
                <span class="comment-author">${c.author || '익명'}</span>
                <span class="comment-date">${dateStr}</span>
            </div>
            <div class="comment-text">${c.commentText || ''}</div>
            <div style="text-align:right">
                <a href="javascript:void(0)" class="btn-delete-comment" onclick="deleteComment(${c.id})">삭제</a>
            </div>
        `);
        list.append(div);
    });
}

function saveComment() {
    var author = $('#commentAuthor').val().trim();
    var commentText = $('#commentContent').val().trim();
    
    if (!author || !commentText) {
        alert('작성자와 댓글 내용을 입력하세요.');
        return;
    }
    
    $.ajax({
        url: '/api/board/posts/' + postId + '/comments',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ author: author, commentText: commentText }),
        success: function() {
            $('#commentAuthor').val('');
            $('#commentContent').val('');
            loadPost();
        },
        error: function() {
            alert('댓글 등록 실패');
        }
    });
}

function deleteComment(commentId) {
    if (!confirm('댓글을 삭제하시겠습니까?')) return;
    
    $.ajax({
        url: '/api/board/comments/' + commentId,
        method: 'DELETE',
        success: function() {
            loadPost();
        },
        error: function() {
            alert('댓글 삭제 실패');
        }
    });
}

function deletePost() {
    if (!confirm('게시글을 삭제하시겠습니까?')) return;
    
    $.ajax({
        url: '/api/board/posts/' + postId + '?author=' + encodeURIComponent(currentPost.author || ''),
        method: 'DELETE',
        success: function() {
            alert('삭제되었습니다.');
            window.location.href = '/board';
        },
        error: function() {
            alert('삭제 실패');
        }
    });
}

function editPost() {
    window.location.href = '/board/edit/' + postId;
}

document.addEventListener('DOMContentLoaded', loadPost);
</script>
</body>
</html>