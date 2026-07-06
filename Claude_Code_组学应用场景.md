# 🧬 Claude Code × 组学：能力全景图

> Claude Code 如何帮助组学小白快速学习各种组学工具并独立完成项目分析

---

## 📖 目录

1. [环境搭建与工具安装](#一环境搭建与工具安装)
2. [组学工具速查与命令生成](#二组学工具速查与命令生成)
3. [数据预处理](#三数据预处理)
4. [上游分析（从读序到矩阵）](#四上游分析从读序到矩阵)
5. [下游分析（从矩阵到生物学发现）](#五下游分析从矩阵到生物学发现)
6. [可视化（从代码到发表级图片）](#六可视化从代码到发表级图片)
7. [代码调试与报错修复](#七代码调试与报错修复)
8. [结果生物学解读](#八结果生物学解读)
9. [科研写作辅助](#九科研写作辅助)
10. [项目管理与可重复性](#十项目管理与可重复性)
11. [组学小白学习路线 × Claude Code 辅助表](#组学小白学习路线--claude-code-辅助表)
12. [总结：Claude Code 对组学小白的核心价值](#总结claude-code-对组学小白的核心价值)

---

## 一、环境搭建与工具安装

**——组学小白最大的痛点**

| 痛点 | Claude Code 如何帮助 |
|------|---------------------|
| 🔧 不知道装什么工具 | "我要做单细胞 ATAC-seq 分析，需要安装哪些软件？" → 列出 chromap、MACS2、ArchR、Signac 等 |
| 🔧 conda/mamba 环境冲突 | 生成正确的 `environment.yml`，帮你排依赖冲突 |
| 🔧 R 包安装失败（依赖缺失） | 诊断缺失的系统库，生成 `apt install` + `install.packages` 组合命令 |
| 🔧 Docker/Singularity 不会用 | 解释概念 + 生成 Dockerfile 或 `singularity pull` 命令 |
| 🔧 GPU 环境配置 | 指导 CUDA/cuDNN 安装，写测试脚本验证 |

> 💡 **实际案例**：小白说"我想装 ArchR 但一直报错"，Claude 能一次性列出所有依赖（devtools、BiocManager、系统级 libxml2-dev 等），按顺序执行即可。

---

## 二、组学工具速查与命令生成

| 工具 | Claude Code 能力 |
|------|-----------------|
| **Cell Ranger** | 生成 `cellranger count` 完整命令，解释每个参数含义 |
| **STARsolo** | 对比 STARsolo vs Cell Ranger，生成比对脚本 |
| **Kallisto / bustools** | 生成从 FASTQ 到表达矩阵的完整 pipeline |
| **Seurat (R)** | 标准流程代码生成：`Normalize → FindVariableFeatures → ScaleData → RunPCA → RunUMAP → FindClusters` |
| **Scanpy (Python)** | 上述 Seurat 流程的 Python 版本，并解释两者差异 |
| **DESeq2** | 从 counts matrix 到火山图的完整代码 |
| **Monocle3 / Slingshot** | 拟时序分析代码生成 + 参数调优建议 |
| **CellChat / NicheNet** | 细胞通讯分析全流程 |
| **pySCENIC / SCENIC** | 转录因子调控网络分析 |
| **Harmony / scVI** | 批次效应校正，对比各方法优劣 |
| **edgeR / limma** | Bulk RNA-seq 差异分析 |
| **MACS2** | ATAC-seq 峰调用 |
| **BWA / Bowtie2** | 短序列比对 |
| **Salmon** | 转录本定量 |

> 🎯 Claude 不只是生成命令，还会**解释每个参数的意义**，让小白真正理解自己在做什么。

---

## 三、数据预处理

```
原始 FASTQ → 质控 → 比对 → 定量 → 表达矩阵
```

| 任务 | Claude Code 帮助 |
|------|-----------------|
| 🧹 FastQC 报告解读 | 粘贴报告关键指标，Claude 告诉你什么是正常的、什么需要关注 |
| 🧹 Trimmomatic / cutadapt 参数选择 | "我的读长是 150bp，接头是 TruSeq，怎么设参数？" |
| 🧹 10x Genomics 文库结构确认 | 解释 R1/R2/I1 的区别，确认 barcode/UMI 位置 |
| 🧹 双端/单端选择 | 根据实验设计推荐分析策略 |
| 🧹 批次效应检查 | 教你如何在早期阶段识别和应对批次效应 |

---

## 四、上游分析（从读序到矩阵）

| 场景 | Claude Code 帮助 |
|------|-----------------|
| 🔬 **DNBelab C4 数据** | 华大平台特有格式处理、STARsolo 参数调优 |
| 🔬 **10x Genomics** | Cell Ranger / Kallisto 流程选择建议 |
| 🔬 **SMART-seq2** | 与 10x 的区别、分析注意事项 |
| 🔬 **空间转录组** | Space Ranger / Seurat Spatial / Squidpy 入门 |
| 🔬 **Bulk RNA-seq** | HISAT2 + featureCounts + DESeq2 全套流程 |
| 🔬 **ATAC-seq** | MACS2 峰调用、DiffBind 差异分析 |
| 🔬 **CUT&Tag** | 与 ChIP-seq 区分，SEACR 参数选择 |
| 🔬 **Metagenomics** | Kraken2 + Bracken 物种注释流程 |

> 🔍 Claude 还能帮你**对比不同工具的结果**，找出差异原因。

---

## 五、下游分析（从矩阵到生物学发现）

| 分析步骤 | Claude Code 能力 |
|---------|-----------------|
| **QC & 过滤** | 生成双峰图、violin plot 诊断代码，解释过滤阈值选取 |
| **归一化** | SCT vs LogNormalize 对比，推荐适用场景 |
| **降维聚类** | PCA + UMAP/t-SNE 代码，分辨率参数选择 |
| **差异表达** | `FindAllMarkers` → 火山图，`p_val_adj` 阈值建议 |
| **细胞注释** | ① SingleR 自动注释 ② 已知 marker 手动注释 ③ 两种方法的结合策略 |
| **富集分析** | GO / KEGG / MSigDB / Reactome，批量运行 + 结果可视化 |
| **拟时序** | Monocle3 / CytoTRACE / Slingshot 选取建议 + 全流程代码 |
| **细胞通讯** | CellChat 完整分析 + 和弦图/热图可视化 |
| **转录因子** | SCENIC / pySCENIC 安装 + 运行 + 结果解读 |
| **RNA velocity** | scVelo / velocyto 流程生成 |
| **拷贝数变异** | inferCNV / CopyKAT 全流程 |

---

## 六、可视化（从代码到发表级图片）

| 图表类型 | Claude Code 生成 |
|---------|-----------------|
| 🗺️ **UMAP / t-SNE** | 按 cluster / group / gene 着色 |
| 🔥 **热图** | 差异基因 / 通路活性 / TF regulon 热图 |
| 🌋 **火山图** | EnhancedVolcano / ggplot2 完整代码 |
| 🎻 **小提琴图 / 气泡图** | 基因/通路表达分布 |
| 📊 **桑基图** | 细胞类型比例变化 |
| 🔵 **Circos 图** | 基因组范围可视化 |
| 📈 **拟时序轨迹图** | Monocle3 / Slingshot 轨迹可视化 |
| 🔗 **和弦图** | CellChat 互作网络 |
| 🌳 **系统发育树** | 物种进化关系 |

> 🎨 Claude 会给出**发表级参数调优建议**（字体大小、配色、分辨率、图例位置等）。

---

## 七、代码调试与报错修复

> 🔥 **这是小白最高频的使用场景！**

```
小白：粘贴一大段红色报错
Claude：① 解释错误原因（中英文都行）
        ② 给出修复方案（有多个备选方案）
        ③ 解释为什么这样修复
        ④ 如果涉及版本不兼容，推荐替代方案
```

### 常见报错类型速查

| 报错类型 | 常见原因 | Claude 修复思路 |
|---------|---------|---------------|
| `package not found` | 未安装 / 版本不匹配 | 检查 BiocManager / conda 源 |
| `memory allocation error` | 数据过大 | 建议降采样 / 分批处理 / 增加 swap |
| `object not found` | 变量名拼写 / 作用域 | 检查代码逻辑 |
| `dimension mismatch` | 矩阵大小不一致 | 检查过滤步骤是否误删基因/细胞 |
| `contrast matrix error` | DESeq2 设计公式错误 | 检查分组因子水平 |
| `connection timed out` | 网络 / 镜像源 | 换镜像源或本地安装 |

---

## 八、结果生物学解读

| 问题 | Claude Code 帮助 |
|------|-----------------|
| ❓ "为什么我的 cluster 3 高表达这些基因？" | 结合 marker 基因推断细胞类型 |
| ❓ "这条通路富集了是什么意思？" | 用通俗语言解释 GO/KEGG 通路 |
| ❓ "我的差异基因里有 XXX，和文献一致吗？" | 检索 PubMed 验证发现 |
| ❓ "两个处理组为什么差异这么小？" | 分析可能原因（样本量、效应大小、批次效应） |
| ❓ "这个 TF regulon 有什么生物学意义？" | 结合文献解释转录因子功能 |

---

## 九、科研写作辅助

| 任务 | Claude Code 能力 |
|------|-----------------|
| ✍️ **Methods 部分** | 根据你的分析流程自动生成方法学段落 |
| ✍️ **图注撰写** | 为每个图生成标准格式图注 |
| ✍️ **结果描述** | "cluster 2 高表达 T cell marker CD3D、CD8A" → 展开成结果段落 |
| ✍️ **讨论部分** | 结合文献背景帮你拓展讨论 |
| ✍️ **文献速览** | 总结一篇论文的核心方法和结论 |
| ✍️ **Abstract 润色** | 优化语言，符合期刊风格 |

---

## 十、项目管理与可重复性

| 需求 | Claude Code 帮助 |
|------|-----------------|
| 📁 **项目目录结构** | 生成标准化的 `project/` 目录 skeleton |
| 📁 **Snakemake / Nextflow** | 从你的分析步骤生成 workflow 骨架 |
| 📁 **Git 版本控制** | 教你怎么 commit、怎么写 `.gitignore` |
| 📁 **README 生成** | 自动为项目写 README.md |
| 📁 **环境导出** | `conda env export` + `sessionInfo()` 完整记录 |
| 📁 **Docker 封装** | 将整个分析环境打包成 Docker 镜像 |

---

## 组学小白学习路线 × Claude Code 辅助表

> 📅 跟着这个路线走，12 周从零到独立完成项目

| 阶段 | 时长 | 核心技能 | 典型工具 | Claude 辅助 |
|------|:--:|---------|---------|------------|
| 🟢 **入门** | 第 1 周 | Linux 基础 + 环境搭建 | conda, Docker, Git | 命令解释、错误修复 |
| 🟢 **基础** | 第 2-3 周 | FASTQ 质控 + 比对 + 定量 | FastQC, STAR, featureCounts | 命令生成、参数解释 |
| 🟡 **进阶** | 第 4-5 周 | Seurat / Scanpy 标准流程 | Seurat, Scanpy | 全流程代码、结果解读 |
| 🟠 **高级** | 第 6-8 周 | 拟时序、细胞通讯、TF 网络 | Monocle3, CellChat, SCENIC | 高级分析代码、生物学解释 |
| 🔴 **实战** | 第 9-12 周 | 独立完成一个完整项目 | 综合运用 | 全流程陪伴式编程 |

---

## 总结：Claude Code 对组学小白的核心价值

| 维度 | 😰 传统方式 | 🤖 Claude Code 辅助 |
|------|-----------|-------------------|
| **学习曲线** | 陡峭，需要翻多个教程 | 自然语言提问，即时获得针对性解答 |
| **报错处理** | Google + StackOverflow，耗时久 | 粘贴报错 → 秒级诊断 + 修复 |
| **代码复用** | 找模板 → 改参数 → 反复试错 | 根据你的数据描述直接生成适配代码 |
| **理解深度** | 照抄代码，不理解原理 | 每步附带解释，边用边学 |
| **项目周期** | 数周到数月 | 显著缩短瓶颈环节时间 |
| **学习持续性** | 容易因挫折放弃 | 即时帮助，保持学习动力 |

---

## 🎯 一句话总结

> **Claude Code 不是替代组学工具，而是让组学小白的每一步都不孤单——既能"告诉我怎么做"，也能"帮我做"，更能"教我怎么理解"。**

---

## 📚 延伸阅读

| 资源 | 说明 |
|------|------|
| [README.md](README.md) | 快速入门 — 30 秒速查卡片 |
| [SKILL.md](SKILL.md) | WispTerm AI 技能定义 — 完整部署流程 |
| [完全指南.md](完全指南.md) | 13 章完整教程 — 面向零基础小白 |
| [Dockerfile](Dockerfile) | Docker 一键部署 |

---

> 🔗 **GitHub Repository**: [ZhaoLabs-SJTU/Claude-test](https://github.com/ZhaoLabs-SJTU/Claude-test)  
> 📅 **最后更新**: 2025-07  
> 🧬 **Made for 组学小白 | Powered by Claude Code**
