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

## 📖 文档结构

| 文件 | 说明 |
|------|------|
| [SKILL.md](SKILL.md) | WispTerm AI 技能定义 |
| [完全指南.md](完全指南.md) | 13 章完整教程，每步命令可复制 |
| README.md (本文件) | 快速参考 |

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

📅 最后更新：2025-07-04 | 🔗 https://github.com/ZhaoLabs-SJTU/Claude-test
