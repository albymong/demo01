-- Board Post Table
CREATE TABLE board_post (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    author VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Attachment Table (파일 경로 저장)
CREATE TABLE board_attachment (
    id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL REFERENCES board_post(id) ON DELETE CASCADE,
    file_path VARCHAR(1024) NOT NULL
);

-- Comment Table
CREATE TABLE board_comment (
    id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL REFERENCES board_post(id) ON DELETE CASCADE,
    author VARCHAR(100) NOT NULL,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
