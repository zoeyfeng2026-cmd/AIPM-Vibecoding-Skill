# 03 · 数据与接口 — 格式示范

> ⚠️ **这是格式示范，不是内容模板。** 参考的是"实体字段怎么列、API 怎么定义"，不是"应该有什么实体"。
>
> 对应模板：`templates/03-data-interfaces.md`

---

## 1. 实体关系

```
books (书籍)
  │
  ├── book_tags (多对多关联表)
  │     │
  │     └── tags (标签)
  │
  └── recommendations (AI 推荐记录，关联到 books.id)

一个 book 可以有多个 tag
一个 tag 可以关联多个 book
一条 recommendation 关联一个推荐的 book
```

## 2. 实体定义

### Book

| 字段 | 类型 | 说明 |
|------|------|------|
| id | TEXT PK | `book-${uuid}` |
| title | TEXT NOT NULL | 书名 |
| author | TEXT | 作者 |
| isbn | TEXT | ISBN-13，可为空 |
| cover_url | TEXT | 封面图片 URL |
| description | TEXT | 简介 |
| status | TEXT NOT NULL | 阅读状态：`want` / `reading` / `done` |
| rating | INTEGER | 评分 1-5，null 表示未评 |
| notes | TEXT | 个人读书笔记 |
| created_at | TEXT NOT NULL | ISO 8601 时间戳 |
| updated_at | TEXT NOT NULL | ISO 8601 时间戳 |

### Tag

| 字段 | 类型 | 说明 |
|------|------|------|
| id | TEXT PK | `tag-${uuid}` |
| name | TEXT NOT NULL UNIQUE | 标签名 |
| color | TEXT | 标签颜色 HEX 值，默认 #8B7355 |

### BookTag

| 字段 | 类型 | 说明 |
|------|------|------|
| book_id | TEXT FK | 关联 books.id |
| tag_id | TEXT FK | 关联 tags.id |
| PRIMARY KEY | (book_id, tag_id) | 联合主键 |

### Recommendation

| 字段 | 类型 | 说明 |
|------|------|------|
| id | TEXT PK | `rec-${uuid}` |
| book_id | TEXT FK | 推荐的书籍 ID（可能是已有的，也可能未入库） |
| reason | TEXT NOT NULL | AI 生成的推荐理由 |
| created_at | TEXT NOT NULL | ISO 8601 时间戳 |

## 3. ID 命名规则

- Book：`book-${uuid}`
- Tag：`tag-${uuid}`
- Recommendation：`rec-${uuid}`

## 4. API 接口

### 书籍 CRUD

```
GET    /api/books                    → { books: Book[] }  支持 ?status=want&tag=小说&q=关键词
GET    /api/books/:id                → { book: Book, tags: Tag[] }
POST   /api/books                    请求体: { title, author?, isbn?, status?, tags?[] } → { book: Book }
PUT    /api/books/:id                请求体: { title?, author?, status?, rating?, notes? } → { book: Book }
DELETE /api/books/:id                → 204
```

### 标签

```
GET    /api/tags                     → { tags: Tag[] }
POST   /api/tags                     请求体: { name, color? } → { tag: Tag }
DELETE /api/tags/:id                 → 204
POST   /api/books/:id/tags           请求体: { tagId } → 201
DELETE /api/books/:id/tags/:tagId    → 204
```

### AI 推荐

```
POST   /api/recommend                请求体: {} → SSE stream
```

### 书籍搜索（外部 API）

```
GET    /api/search?q=关键词          → { results: [{ title, author, isbn, cover_url, description }] }
```

## 5. 流式接口

AI 推荐接口使用 SSE 流式返回：

```
事件类型：SSE
事件序列：
  event: status     { message: "正在分析你的阅读偏好..." }
  event: status     { message: "正在搜索候选书籍..." }
  event: book       { title, author, cover_url, description }    ← 候选书籍信息
  event: reason     { content: "推荐理由的增量文本" }*            ← 流式输出推荐理由
  event: done       { recommendationId }
```
