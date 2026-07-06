# =============================================
# Claude Code Docker Image
# 面向组学分析人员的 AI 编程助手容器
# =============================================
FROM node:lts-slim

LABEL maintainer="ZhaoLabs-SJTU"
LABEL description="Claude Code — AI coding assistant for bioinformatics researchers"
LABEL version="1.0"

# ---------- 系统依赖 ----------
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# ---------- 创建非 root 用户 ----------
RUN useradd -m -s /bin/bash claude && \
    mkdir -p /home/claude/.claude /workspace && \
    chown -R claude:claude /home/claude /workspace

# ---------- 安装 Claude Code ----------
RUN npm install -g @anthropic-ai/claude-code

# ---------- 入口脚本 ----------
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# ---------- 切换用户与工作目录 ----------
USER claude
WORKDIR /workspace

ENTRYPOINT ["/entrypoint.sh"]
CMD ["claude"]
