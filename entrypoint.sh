#!/bin/bash
# =============================================
# Claude Code Docker Entrypoint
# 支持交互模式与命令行参数两种使用方式
# =============================================

# ---------- 自动生成 settings.json（如果不存在） ----------
SETTINGS_FILE="/home/claude/.claude/settings.json"
if [ ! -f "$SETTINGS_FILE" ] && [ -n "$ANTHROPIC_BASE_URL" ]; then
    echo "[entrypoint] 未检测到配置文件，根据环境变量自动生成 settings.json ..."
    cat > "$SETTINGS_FILE" << JSONEOF
{
  "model": "${CLAUDE_MODEL:-MiniMax-M2.7}",
  "permissionMode": "${PERMISSION_MODE:-acceptEdits}",
  "env": {
    "ANTHROPIC_BASE_URL": "${ANTHROPIC_BASE_URL}",
    "ANTHROPIC_API_KEY": "${ANTHROPIC_API_KEY}",
    "API_TIMEOUT_MS": "${API_TIMEOUT_MS:-600000}",
    "DISABLE_NONESSENTIAL_TRAFFIC": "1",
    "CLAUDE_CODE_DISABLE_TERMINAL_TITLE": "1"
  },
  "autoCompact": {
    "enabled": true,
    "maxTokens": 512000
  }
}
JSONEOF
    echo "[entrypoint] 配置已自动生成。"
fi

# ---------- 模式判断 ----------
if [ $# -gt 0 ]; then
    # 有参数：传递给 claude 命令
    exec claude "$@"
else
    # 无参数：启动交互式会话
    echo "========================================="
    echo "  Claude Code Docker Container"
    echo "  模型: ${CLAUDE_MODEL:-MiniMax-M2.7}"
    echo "  工作目录: /workspace"
    echo "  输入 /help 查看帮助"
    echo "========================================="
    exec claude
fi
