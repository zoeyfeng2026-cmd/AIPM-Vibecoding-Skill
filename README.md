# AIPM-Vibecoding-Skill

Vibe Coding 专用 Skill 库。面向非技术背景的产品经理，通过自然语言指挥 AI 写代码来构建产品。

## 这是什么

这是一套 Claude Code Skill 集合，解决 vibe coding 过程中的核心问题：

- AI 不知道你想要什么 → 需要一份 AI 能直接执行的 PRD
- AI 会自作主张 → 需要明确的技术约束
- AI 会漏掉边界条件 → 需要兜底策略和验证标准

每个 Skill 封装了一个完整的最佳实践，安装后通过斜杠命令触发。

## 可用 Skill

| Skill | 触发命令 | 用途 | 状态 |
|-------|---------|------|------|
| **vibe-prd** | `/vibe-prd` | 引导撰写写给 AI 看的 PRD（4 阶段流程 + 5 模块） | v1.0.0 |

更多 Skill 持续添加中。

## 安装

### 方式一：安装脚本（推荐）

```bash
git clone https://github.com/zoeyfeng2026-cmd/AIPM-Vibecoding-Skill.git
cd AIPM-Vibecoding-Skill
./install.sh
```

### 方式二：手动安装

```bash
# 复制 skill 文件
cp -r skills/<skill-name> ~/.agents/skills/

# 创建符号链接
ln -sf ../../.agents/skills/<skill-name> ~/.claude/skills/<skill-name>
```

### 卸载

```bash
rm -rf ~/.agents/skills/<skill-name>
rm ~/.claude/skills/<skill-name>
```

## 文件结构

```
AIPM-Vibecoding-Skill/
├── README.md               ← 本文件
├── install.sh              ← 一键安装脚本
└── skills/
    └── vibe-prd/           ← PRD 撰写 Skill
        ├── SKILL.md        ← 主定义
        ├── README.md       ← 技能说明
        ├── checklist.md    ← 自查清单
        ├── templates/      ← 空白模板
        └── example/        ← 格式示范
```

## 更新日志

| 日期 | 版本 | 内容 |
|------|------|------|
| 2026-05-04 | v1.0.0 | 首次发布 vibe-prd Skill（4 阶段流程 + 5 模块模板 + 自查清单） |

## License

MIT
