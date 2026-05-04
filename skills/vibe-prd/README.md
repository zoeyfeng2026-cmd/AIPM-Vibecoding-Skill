# vibe-prd

写给 AI 看的产品需求文档撰写 Skill。

## 适用场景

你是非技术背景的产品经理，想通过自然语言指挥 AI（Claude Code、Cursor 等）写代码来构建产品。你需要先写一份 AI 能直接执行的 PRD，再让 AI 基于 PRD 写代码。

**不适用于**：传统开发流程的 PRD、面向人类读者的需求文档。

## 触发方式

- 输入 `/vibe-prd`
- 说"写 vibe coding 的 PRD"
- 说"用 vibe coding 做一个 XX 产品"并需要先写需求

## 做什么

AI 通过 4 个阶段引导你完成 PRD 撰写：

| 阶段 | 做什么 | 产出 |
|------|--------|------|
| 1. 需求理解 | 提问收集信息，输出需求摘要 | 你确认后继续 |
| 2. 架构设计 | 设计页面结构、数据核心、技术方案 | 你确认后继续 |
| 3. PRD 撰写 | 逐模块写 5 个文档，每模块确认一次 | 5 个 .md 文件 |
| 4. 二次确认 | 一致性检查 + 生成最终文件 | PRD/ + CLAUDE.md |

## 5 个模块

| 模块 | 文件 | 解决什么问题 |
|------|------|-------------|
| 产品意图 | `01-product-intent.md` | AI 没有项目背景，需要决策锚点 |
| 技术约束 | `02-tech-constraints.md` | AI 会自作主张选技术栈 |
| 数据与接口 | `03-data-interfaces.md` | AI 会在不同文件里重复定义类型 |
| 交互与设计 | `04-interaction-design.md` | AI 不知道"点按钮发生什么" |
| 验证与边界 | `05-verification.md` | AI 会省略错误处理和边界条件 |

## 文件结构

```
vibe-prd/
├── SKILL.md           ← Skill 主定义（触发条件 + 4 阶段流程 + 5 模块规则）
├── README.md          ← 本文件
├── checklist.md       ← PRD 写完后的自查清单（28 项检查）
├── templates/         ← 5 个空白模板（PM 可直接填写）
│   ├── 01-product-intent.md
│   ├── 02-tech-constraints.md
│   ├── 03-data-interfaces.md
│   ├── 04-interaction-design.md
│   └── 05-verification.md
└── example/           ← 格式示范（展示每个模块的写作标准）
    ├── README.md
    ├── 01-product-intent.md
    ├── 02-tech-constraints.md
    ├── 03-data-interfaces.md
    ├── 04-interaction-design.md
    └── 05-verification.md
```

## 两种使用方式

- **方式 A**（推荐）：输入 `/vibe-prd`，AI 交互式引导你填写
- **方式 B**：在 `templates/` 中自行填写，填完让 AI 读取执行

## 设计原则

- **传统 PRD 写给人看**，可以模糊、口头补充上下文
- **Vibe Coding PRD 写给 AI 看**，必须精确、自包含、可执行
- 核心公式：**描述怎么做 + 不做什么 + 怎么验证做对了**
