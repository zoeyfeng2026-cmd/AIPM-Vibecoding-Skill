# 02 · 技术约束 — 格式示范

> ⚠️ **这是格式示范，不是内容模板。** 参考的是"每个技术层怎么指定版本+理由"，不是"应该用什么技术栈"。
>
> 对应模板：`templates/02-tech-constraints.md`

---

## 1. 技术栈

| 层级 | 技术 | 版本 | 理由 |
|------|------|------|------|
| 框架 | Next.js | 14 (App Router) | 全栈框架，前端+API 一体，部署简单 |
| 语言 | TypeScript | 5.x | 类型安全，减少运行时错误 |
| 样式 | Tailwind CSS | 3.4 | 原子化 CSS，开发速度快 |
| 数据库 | SQLite (better-sqlite3) | 11.x | 零配置，单文件，本地运行，无需外部服务 |
| AI 调用 | OpenAI SDK | 4.x | 调用 aihubmix 的 OpenAI 兼容接口 |
| 搜索 | Tavily SDK | 0.x | AI 搜索 API，用于补充书籍信息 |

## 2. 部署方案

**本地开发**：`npm run dev`，SQLite 数据库文件存在项目根目录 `./data/bookshelf.db`

**生产部署**：Vercel（注意：Vercel 无持久化存储，V1 仅本地运行。如需线上部署后续改用 Turso）

## 3. 环境变量

| 变量名 | 必需 | 说明 |
|--------|------|------|
| AIHUBMIX_API_KEY | 是 | aihubmix 的 API Key，用于 AI 推荐 |
| AIHUBMIX_BASE_URL | 否 | 默认 https://aihubmix.com/v1 |
| AI_MODEL | 否 | 默认 claude-opus-4-6 |
| TAVILY_API_KEY | 否 | Tavily 搜索 API Key，不配则搜索功能不可用 |

## 4. 第三方服务

| 服务 | 用途 | 接入方式 |
|------|------|---------|
| aihubmix | AI 推荐（调用 LLM 生成推荐理由） | OpenAI 兼容格式，base URL: https://aihubmix.com/v1 |
| Tavily | 搜索书籍信息（封面、简介、ISBN） | REST API，用 tavily-sdk 调用 |
| Google Books API | 补充书籍元数据（公开 API，无需 Key） | REST API，免费 |

## 5. 禁止项

- 不引入向量数据库（V1 用关键词匹配搜索即可）
- 不引入 Docker（本地直接运行）
- 不使用 SSR / SSG（全部客户端渲染 + API Routes，数据来自 SQLite）
- 不引入 UI 组件库（用 Tailwind 自己写，保持轻量）
- 不引入 ORM（直接写 SQL，项目简单不需要抽象层）
