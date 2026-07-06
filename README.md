# Claude Code 安装配置完全指南

> 🚀 面向零基础组学分析小白的 Claude Code 部署指南  
> 📦 适用于 WSL/Linux/macOS | 支持 MiniMax / Anthropic API

## ⚡ 30 秒速查

```bash
# 1. 环境
nvm install --lts && nvm use --lts

# 2. 安装
npm install -g @anthropic-ai/claude-code

# 3. 配置 (MiniMax 国内用户)
mkdir -p ~/.claude
cat > ~/.claude/settings.json << 'EOF'
{
  "model": "MiniMax-M2.7",
  "permissionMode": "acceptEdits",
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.minimax.chat/anthropic",
    "ANTHROPIC_API_KEY": "sk-你的API-Key",
    "API_TIMEOUT_MS": "600000",
    "DISABLE_NONESSENTIAL_TRAFFIC": "1"
  },
  "autoCompact": { "enabled": true, "maxTokens": 512000 }
}
EOF

# 4. 验证
claude --version
claude -p "回复OK"
```

> ⚠️ **MiniMax API 注意**：不同环境可能使用 `ANTHROPIC_AUTH_TOKEN` 代替 `ANTHROPIC_API_KEY`，API 地址也可能为 `api.minimaxi.com`。详见 [完全指南.md](完全指南.md) 第四章。

## 📖 文档结构

| 文件 | 说明 |
|------|------|
| [SKILL.md](SKILL.md) | WispTerm AI 技能定义 |
| [完全指南.md](完全指南.md) | 13 章完整教程，每步命令可复制 |
| README.md (本文件) | 快速参考 |
| [Claude_Code_从零到精通_完全指南.docx](Claude_Code_从零到精通_完全指南.docx) | Word 文档，可打印版 |
| [Claude_Code_从零到精通_完全指南.pptx](Claude_Code_从零到精通_完全指南.pptx) | PPT 幻灯片 |

## 🚨 CLAUDE.md 重要性

> ⭐ **不配置 CLAUDE.md，Claude 就像不了解你的新同事！** 配置只需 5 分钟，但能显著提升回复质量。详见 [SKILL.md 第 8 步](SKILL.md)。

## 🔑 推荐模型策略

| 场景 | 模型 |
|------|------|
| 日常编程 / 问答 | MiniMax-M2.7 |
| 复杂分析 / 重构 | MiniMax-M3 |

## 🛠 命令速查

| 命令 | 说明 |
|------|------|
| `claude` | 交互式会话 |
| `claude -p "问题"` | 单次问答 |
| `/init` | 生成项目 CLAUDE.md |
| `/clear` | 清除上下文 |
| `/compact` | 压缩对话 |
| `/cost` | 查看费用 |

## 📋 要求

- Node.js ≥ 18（推荐 LTS）
- WSL2 / Linux / macOS

---

📅 最后更新：2025-07-06 | 🔗 https://github.com/ZhaoLabs-SJTU/Claude-test
