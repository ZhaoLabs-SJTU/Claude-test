---
name: claude-test
description: Claude Code 从零安装、配置与使用。涵盖 nvm/Node.js 安装、Claude Code 部署、MiniMax API 认证、settings.json 三层配置、模型选择策略、权限模式、CLAUDE.md 记忆文件、IDE 集成、命令速查、四个实战工作流、FAQ 故障排查。
---

# Claude Code 安装配置完全指南

## 文档导航

> 本技能随 GitHub 仓库 [Claude-test](https://github.com/ZhaoLabs-SJTU/Claude-test) 分发。

| 文件 | 用途 |
|------|------|
| **SKILL.md** (本文件) | AI 技能定义，供 WispTerm Agent 加载使用 |
| [README.md](README.md) | 快速参考卡片，30 秒速查 |
| [完全指南.md](完全指南.md) | 面向零基础小白的 13 章完整教程 |

---

## 概述

本技能帮助组学分析人员从零开始完成 Claude Code 的完整部署与配置：

1. **环境准备** — nvm + Node.js 安装
2. **安装 Claude Code** — npm 全局安装 / npx 直接运行
3. **认证配置** — Anthropic 官方 / MiniMax 第三方 API
4. **参数调优** — settings.json 三层配置、模型选择、权限模式
5. **实战使用** — 四个典型工作流
6. **故障排查** — 10 个 FAQ

---

## 第 1 步：环境准备

### 1.1 安装 nvm (Node Version Manager)

**WSL / Linux：**

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
source ~/.bashrc
nvm --version
```

**macOS：**

```bash
brew install nvm
# 然后在 ~/.zshrc 中添加：
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"
source ~/.zshrc
```

**Windows (无法直接装 nvm，走 WSL)：**

```powershell
wsl --install -d Ubuntu
# 进入 WSL 后按上方 Linux 流程操作
```

### 1.2 安装 Node.js

```bash
nvm install --lts
nvm use --lts
node --version    # 应显示 v22.x 或 v24.x
npm --version
```

> ⚠️ Claude Code 需要 Node.js ≥ 18。推荐使用 LTS 版本。

---

## 第 2 步：安装 Claude Code

### 方式 A：npm 全局安装（推荐）

```bash
npm install -g @anthropic-ai/claude-code
claude --version
```

### 方式 B：npx 不安装直接运行

```bash
npx @anthropic-ai/claude-code
```

### 方式 C：更新到最新版

```bash
npm update -g @anthropic-ai/claude-code
claude --version
```

### 常见安装错误

| 错误 | 原因 | 解决 |
|------|------|------|
| `command not found` | npm 全局 bin 不在 PATH | `export PATH="$HOME/.nvm/versions/node/$(node -v)/bin:$PATH"` |
| `EACCES` | 权限不足 | 不要用 sudo；用 nvm 管理 Node.js |
| `npm ERR! 404` | npm registry 问题 | `npm config set registry https://registry.npmjs.org/` |
| `Node.js version too old` | Node < 18 | `nvm install --lts && nvm use --lts` |

---

## 第 3 步：认证配置

### 3.1 配置目录

```bash
mkdir -p ~/.claude
```

### 3.2 Anthropic 官方 API（推荐海外用户）

```bash
cat > ~/.claude/settings.json << 'EOF'
{
  "model": "claude-sonnet-4-20250514",
  "apiKeyHelper": "claude-keys"
}
EOF
```

然后将 API Key 存储到系统 keychain：

```bash
echo "sk-ant-xxxxx" | claude-keys store
```

### 3.3 MiniMax 第三方 API（国内用户首选）

```bash
cat > ~/.claude/settings.json << 'EOF'
{
  "model": "MiniMax-M2.7",
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.minimax.chat/anthropic",
    "ANTHROPIC_API_KEY": "sk-你的MiniMax-API-Key",
    "API_TIMEOUT_MS": "600000",
    "DISABLE_NONESSENTIAL_TRAFFIC": "1",
    "CLAUDE_CODE_DISABLE_TERMINAL_TITLE": "1"
  },
  "autoCompact": {
    "enabled": true,
    "maxTokens": 512000
  }
}
EOF
```

### 3.4 验证认证

```bash
claude --version
claude -p "回复OK" 2>&1 | tail -5
```

---

## 第 4 步：三层配置架构

Claude Code 使用**三层配置合并**，后层覆盖前层：

| 层级 | 路径 | 作用域 | 典型用途 |
|------|------|--------|----------|
| 全局 | `~/.claude/settings.json` | 所有项目 | API 认证、默认模型 |
| 项目 | `<项目根>/.claude/settings.json` | 当前项目 | 项目特定模型/权限 |
| 本地 | `<项目根>/.claude/settings.local.json` | 当前项目 + 本机 | 个人偏好，不入 git |

> ⚠️ `.claude/settings.local.json` 应加入 `.gitignore`，避免泄露个人 API Key。

---

## 第 5 步：核心参数详解

```json
{
  "model": "MiniMax-M2.7",
  "permissionMode": "acceptEdits",
  "autoCompact": {
    "enabled": true,
    "maxTokens": 512000
  },
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.minimax.chat/anthropic",
    "ANTHROPIC_API_KEY": "sk-你的API-Key",
    "API_TIMEOUT_MS": "600000",
    "DISABLE_NONESSENTIAL_TRAFFIC": "1",
    "CLAUDE_CODE_DISABLE_TERMINAL_TITLE": "1"
  }
}
```

### 参数速查表

| 参数 | 默认值 | 说明 | 推荐值 |
|------|--------|------|--------|
| `model` | — | 使用的模型名称 | MiniMax-M2.7（日常）/ MiniMax-M3（复杂） |
| `permissionMode` | `default` | 权限模式 | `acceptEdits`（自动接受编辑） |
| `autoCompact.enabled` | true | 自动压缩长对话 | true |
| `autoCompact.maxTokens` | — | 触发压缩的 token 阈值 | 512000 |
| `API_TIMEOUT_MS` | 600000 | API 超时 (ms) | 600000 (10分钟) |
| `DISABLE_NONESSENTIAL_TRAFFIC` | 0 | 禁用非必要网络流量 | 1 |
| `CLAUDE_CODE_DISABLE_TERMINAL_TITLE` | 0 | 禁用终端标题修改 | 1 |

---

## 第 6 步：模型选择

### MiniMax 平台模型对比

| 模型 | 定位 | 速度 | 成本 | 适用场景 |
|------|------|------|------|----------|
| **MiniMax-M2.7** | 均衡型 | 快 | 中 | 日常编程、问答、代码解释 |
| **MiniMax-M3** | 旗舰型 | 中 | 高 | 复杂分析、大型重构、算法设计 |

### 推荐策略

```
日常开发 + 简单问题 → MiniMax-M2.7（快、省）
复杂分析 + 大型重构 → MiniMax-M3（强、准）
单细胞数据处理       → 看任务复杂度选择
```

---

## 第 7 步：权限模式

| 模式 | 读文件 | 写文件 | 执行命令 | 推荐场景 |
|------|:--:|:--:|:--:|------|
| `default` | 自动 | 确认 | 确认 | 新手、安全优先 |
| `acceptEdits` | 自动 | 自动 | 确认 | **日常使用（推荐）** |
| `bypassPermissions` | 自动 | 自动 | 自动 | 信任环境 |
| `plan` | 只读 | 禁止 | 禁止 | 仅分析、不出手 |

```json
{ "permissionMode": "acceptEdits" }
```

> 🔒 安全提示：生产服务器建议使用 `default`，本地开发用 `acceptEdits`。

---

## 第 8 步：CLAUDE.md 记忆文件

### 全局 CLAUDE.md

```bash
cat > ~/.claude/CLAUDE.md << 'EOF'
# 全局偏好

- 我是生物信息学研究员，主要做单细胞转录组分析
- 工作环境：WSL2 Ubuntu 22.04，conda 管理 Python 环境
- 常用工具：STARsolo, dnbc4tools, Seurat, Scanpy
- 代码风格：Python 用 uv 管理依赖，R 用 renv
- 注释用中文，变量名用英文
EOF
```

### 项目级 CLAUDE.md

在项目根目录创建 `.claude/CLAUDE.md`，内容为项目特定说明。

### 使用 /init 自动生成

在 Claude Code 交互式会话中输入：

```
/init
```

Claude 会自动分析项目并生成 `.claude/CLAUDE.md`。

---

## 第 9 步：IDE 集成

### VS Code

```bash
# 在 VS Code 终端中直接使用
claude
```

或安装 Claude Code 扩展。

### JetBrains (PyCharm / IntelliJ)

在 Terminal 面板中直接使用 `claude` 命令。

### WispTerm

在 WispTerm 中打开终端，直接使用 `claude` 命令，或通过 AI Agent 调用。

---

## 第 10 步：命令速查

### 启动命令

| 命令 | 说明 |
|------|------|
| `claude` | 启动交互式会话 |
| `claude -p "问题"` | 单次问答 |
| `claude -p "问题" --model MiniMax-M3` | 指定模型单次问答 |
| `claude --version` | 查看版本 |
| `claude -c` | 继续上次会话 |
| `claude -r "<session-id>"` | 恢复指定会话 |

### 会话内命令

| 命令 | 说明 |
|------|------|
| `/help` | 帮助 |
| `/clear` | 清除上下文 |
| `/compact` | 手动压缩对话 |
| `/init` | 生成项目 CLAUDE.md |
| `/model` | 查看/切换模型 |
| `/permission` | 查看/切换权限模式 |
| `/memory` | 管理记忆 |
| `/cost` | 查看费用统计 |
| `/bashes` | 查看后台任务 |
| `/status` | 查看当前状态 |
| `/logout` | 退出所有账号 |

### 快捷键

| 快捷键 | 说明 |
|------|------|
| `Ctrl+C` | 中断当前操作 |
| `Ctrl+D` | 退出会话 |
| `Ctrl+L` | 清除屏幕 |
| `Ctrl+R` | 搜索历史 |

---

## 第 11 步：四个实战工作流

### 工作流 1：新项目上手

```bash
cd /path/to/project
claude
```
```
> 帮我理解这个项目的结构
> 项目依赖是什么？如何安装？
> 在 CLAUDE.md 中记录项目结构偏好
```

### 工作流 2：代码审查

```bash
cd /path/to/project
claude -p "Review the latest git diff for correctness, performance, and security issues."
```

### 工作流 3：Bug 修复

```
> 运行 tests/test_analysis.py 看看报错
> 分析报错原因并修复
> 重新运行测试验证
```

### 工作流 4：单细胞数据分析

```
> 检查当前目录的 FASTQ 文件命名是否符合 dnbc4tools 规范
> 帮我校验参考基因组索引完整性
> 生成 STARsolo 比对命令
```

---

## 第 12 步：FAQ 故障排查

### Q1: `claude: command not found`

```bash
npm list -g @anthropic-ai/claude-code
export PATH="$HOME/.nvm/versions/node/$(node -v)/bin:$PATH"
```

### Q2: 认证失败 `401 Unauthorized`

检查 API Key 是否正确：`cat ~/.claude/settings.json | grep API_KEY`

### Q3: 超时 `Request timed out`

增加超时：`"API_TIMEOUT_MS": "1200000"` 或检查网络。

### Q4: 模型不存在 `Model not found`

确认 MiniMax 平台是否支持该模型；检查模型名拼写。

### Q5: token 超出限制

使用 `/compact` 压缩对话，或调低 `autoCompact.maxTokens`。

### Q6: 权限确认太频繁

修改 `permissionMode` 为 `acceptEdits`。

### Q7: npm 安装失败

```bash
npm cache clean --force
npm config set registry https://registry.npmjs.org/
npm install -g @anthropic-ai/claude-code
```

### Q8: Node.js 版本不兼容

```bash
nvm install --lts
nvm use --lts
```

### Q9: 对话太长导致卡顿

```bash
/compact
```

### Q10: 如何切换 API 提供商

编辑 `~/.claude/settings.json` 中的 `ANTHROPIC_BASE_URL` 和 `ANTHROPIC_API_KEY`。

---

## 环境变量速查

| 变量 | 说明 | 示例值 |
|------|------|------|
| `ANTHROPIC_BASE_URL` | API 基地址 | `https://api.minimax.chat/anthropic` |
| `ANTHROPIC_API_KEY` | API Key | `sk-xxxxxxxx` |
| `API_TIMEOUT_MS` | 超时 (ms) | `600000` |
| `DISABLE_NONESSENTIAL_TRAFFIC` | 禁用遥测 | `1` |
| `CLAUDE_CODE_DISABLE_TERMINAL_TITLE` | 禁用标题修改 | `1` |
| `CLAUDE_CODE_MAX_OUTPUT_TOKENS` | 最大输出 token | `32000` |

---

## 要求

- Node.js ≥ 18（推荐 LTS）
- npm ≥ 9
- 网络可访问 MiniMax API (`https://api.minimax.chat`)
- WSL2 / Linux / macOS（Windows 需通过 WSL 使用）

---

## 版本历史

| 版本 | 日期 | 变更 |
|------|------|------|
| v1.0 | 2025-07-04 | 初始版本：12 步完整部署流程、参数详解、FAQ |
