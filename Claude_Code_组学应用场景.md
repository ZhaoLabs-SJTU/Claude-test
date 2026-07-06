# 🧬 Claude Code × 组学：从零到精通完全实战手册

> **Claude Code 如何帮助组学零基础小白安装工具、测试示范数据、解决报错，并最终独立完成组学项目分析**

---

## 📖 目录

### 第一篇：工具安装篇（14 个工具，手把手教学）
- [1.1 conda/mamba 环境管理](#11-condamamba-环境管理)
- [1.2 R 和 RStudio Server](#12-r-和-rstudio-server)
- [1.3 Seurat 单细胞分析生态](#13-seurat-单细胞分析生态)
- [1.4 Scanpy 单细胞分析生态](#14-scanpy-单细胞分析生态)
- [1.5 Cell Ranger (10x Genomics)](#15-cell-ranger-10x-genomics)
- [1.6 STARsolo](#16-starsolo)
- [1.7 Kallisto / bustools](#17-kallisto--bustools)
- [1.8 DESeq2 (Bulk RNA-seq 差异分析)](#18-deseq2-bulk-rna-seq-差异分析)
- [1.9 Monocle3 (拟时序分析)](#19-monocle3-拟时序分析)
- [1.10 CellChat (细胞通讯分析)](#110-cellchat-细胞通讯分析)
- [1.11 SCENIC / pySCENIC (转录因子调控网络)](#111-scenic--pyscenic-转录因子调控网络)
- [1.12 MACS2 (ATAC-seq 峰调用)](#112-macs2-atac-seq-峰调用)
- [1.13 ArchR / Signac (单细胞 ATAC-seq)](#113-archr--signac-单细胞-atac-seq)
- [1.14 其他常用工具速装](#114-其他常用工具速装)

### 第二篇：示范数据测试篇（7 个示例数据集，从入门到进阶）
- [2.1 Seurat 官方 pbmc3k 教程](#21-seurat-官方-pbmc3k-教程)
- [2.2 Scanpy 官方 pbmc3k 教程](#22-scanpy-官方-pbmc3k-教程)
- [2.3 Cell Ranger 官方 small dataset](#23-cell-ranger-官方-small-dataset)
- [2.4 Bulk RNA-seq 示例 (airway 数据集)](#24-bulk-rna-seq-示例-airway-数据集)
- [2.5 单细胞 ATAC-seq 示例](#25-单细胞-atac-seq-示例)
- [2.6 CellChat 示例数据](#26-cellchat-示例数据)
- [2.7 Monocle3 拟时序示例](#27-monocle3-拟时序示例)

### 第三篇：报错解决篇（17 类常见错误，逐类击破）
- [3.1 环境/安装类错误](#31-环境安装类错误)
- [3.2 内存不足类错误](#32-内存不足类错误)
- [3.3 数据格式/类型错误](#33-数据格式类型错误)
- [3.4 包版本兼容性错误](#34-包版本兼容性错误)
- [3.5 文件路径/权限错误](#35-文件路径权限错误)
- [3.6 Seurat/Scanpy 专项错误](#36-seuratscanpy-专项错误)
- [3.7 比对/定量工具错误](#37-比对定量工具错误)
- [3.8 网络/下载错误](#38-网络下载错误)

### 附录
- [附录 A：Claude Code 对话技巧速查](#附录-aclaude-code-对话技巧速查)
- [附录 B：组学项目标准目录结构](#附录-b组学项目标准目录结构)
- [附录 C：12 周从零到实战学习路线](#附录-c12-周从零到实战学习路线)

---

# 第一篇：工具安装篇

> **核心理念**：你不必记住每个工具的安装命令——你只需知道如何向 Claude Code 描述你的需求，它会帮你生成精确的安装步骤。

---

## 1.1 conda/mamba 环境管理

### 这是什么？
conda 是生物信息学最常用的包和环境管理器。mamba 是 conda 的加速版，安装速度更快。**组学分析第一课：学会用 conda 创建隔离的分析环境。**

### 前提条件
- 已安装 conda (Miniconda 或 Anaconda) 或 mamba
- 如尚未安装，可以在 Claude 中输入：

> **👤 小白**：我的服务器是 Ubuntu 22.04，怎么安装 mamba？

> **🤖 Claude Code 回复**：
> ```bash
> # 下载并安装 Miniforge（自带 mamba）
> curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
> bash Miniforge3-$(uname)-$(uname -m).sh -b -p $HOME/miniforge3
> $HOME/miniforge3/bin/conda init bash
> exec bash
> # 验证
> mamba --version
> ```

### 使用 Claude 管理环境的典型对话

**场景 1：创建新环境**

> **👤 小白**：帮我创建一个叫 `singlecell` 的 conda 环境，用 Python 3.10

> **🤖 Claude Code 回复**：
> ```bash
> mamba create -n singlecell python=3.10 -y
> mamba activate singlecell
> ```

**场景 2：环境冲突怎么办**

> **👤 小白**：我装 scanpy 时报错 "package conflicts"，怎么办？

> **🤖 Claude Code 回复**：这说明你的环境中已有包的版本与 scanpy 冲突。推荐从干净环境开始：
> ```bash
> mamba create -n singlecell python=3.10 -y
> mamba activate singlecell
> mamba install -c conda-forge scanpy -y
> ```
> 如果仍然冲突，尝试 `mamba install -c conda-forge scanpy --strict-channel-priority` 强制指定优先级。

**场景 3：环境导出与共享**

> **👤 小白**：怎么把我的环境分享给实验室其他人？

> **🤖 Claude Code 回复**：
> ```bash
> # 导出环境
> conda env export -n singlecell > environment.yml
> # 其他人使用
> mamba env create -f environment.yml
> ```

### 常见 conda 问题速查

| 问题 | Claude 给出的解决命令 |
|------|---------------------|
| 下载慢 | 换清华镜像：修改 `~/.condarc` 添加 `https://mirrors.tuna.tsinghua.edu.cn/anaconda/` |
| 环境损坏 | `conda env remove -n 环境名` 然后重建 |
| 不小心装错了包 | `mamba remove 包名 -y` |
| 磁盘不够 | `conda clean --all -y` 清理缓存 |

---

## 1.2 R 和 RStudio Server

### 这是什么？
R 是组学数据分析（尤其是单细胞、差异表达、可视化）的主流语言。RStudio Server 让你通过浏览器使用 R。

### Claude 辅助安装全流程

> **👤 小白**：我想在 Ubuntu 服务器上安装 R 4.3 和 RStudio Server，给我一步一步的命令

> **🤖 Claude Code 回复**：
> ```bash
> # === 第一步：安装 R 4.3 ===
> # 添加 R 官方源
> sudo apt update
> sudo apt install --no-install-recommends software-properties-common dirmngr -y
> wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | \
>   sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
> sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" -y
> 
> # 安装 R
> sudo apt install r-base r-base-dev -y
> R --version   # 验证
> 
> # === 第二步：安装系统依赖库（很多 R 包需要） ===
> sudo apt install -y \
>   libcurl4-openssl-dev libssl-dev libxml2-dev \
>   libfontconfig1-dev libharfbuzz-dev libfribidi-dev \
>   libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev \
>   libgdal-dev libgeos-dev libproj-dev \
>   libhdf5-dev libnetcdf-dev \
>   libbz2-dev liblzma-dev libzstd-dev
> 
> # === 第三步：安装 RStudio Server ===
> sudo apt install gdebi-core -y
> wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2024.04.2-764-amd64.deb
> sudo gdebi rstudio-server-2024.04.2-764-amd64.deb -n
> # 浏览器访问 http://你的服务器IP:8787
> ```

> **👤 小白**：安装时 wget 报错 404 找不到文件

> **🤖 Claude Code 回复**：RStudio 版本号经常更新。去 https://posit.co/download/rstudio-server/ 确认最新版本的下载链接，或者在终端执行：
> ```bash
> # 自动获取最新版本
> LATEST=$(curl -s https://download2.rstudio.org/server/jammy/amd64/ | \
>   grep -oP 'rstudio-server-[0-9.]+-[0-9]+-amd64.deb' | sort -V | tail -1)
> wget "https://download2.rstudio.org/server/jammy/amd64/$LATEST"
> ```

### 使用 Claude 安装 R 包的技巧

```
小白：帮我安装 Seurat
Claude：先打开 R，然后执行：
  install.packages('Seurat')
  如果报错，试试：
  install.packages('remotes')
  remotes::install_cran('Seurat')

小白：install.packages 太慢怎么办
Claude：设置国内镜像（在 R 中执行）：
  options(repos = c(CRAN = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
  或永久设置：在 ~/.Rprofile 中添加上面这行
```

---

## 1.3 Seurat 单细胞分析生态

### 这是什么？
Seurat 是 R 语言中最流行的单细胞 RNA-seq 分析工具包，由 Rahul Satija 实验室开发。**这是单细胞小白入门的第一站。**

### 完整安装流程（Claude 对话实录）

> **👤 小白**：帮我在 R 4.3 上安装 Seurat v5，包括所有依赖

> **🤖 Claude Code 回复**：打开 R，按顺序执行以下命令。每步完成后确认没有 error 再继续：

```r
# === 第 1 步：安装基础依赖 ===
install.packages(c("remotes", "devtools", "BiocManager"))

# === 第 2 步：安装 Bioconductor 依赖（这是最容易出错的步骤） ===
BiocManager::install(c(
  "SingleCellExperiment",
  "SummarizedExperiment",
  "GenomicRanges",
  "IRanges",
  "S4Vectors",
  "BiocGenerics",
  "Biobase",
  "MatrixGenerics",
  "DelayedArray",
  "BiocParallel",
  "limma"
), update = FALSE, ask = FALSE)

# === 第 3 步：安装 Seurat v5 ===
install.packages("Seurat")

# === 第 4 步：验证 ===
library(Seurat)
packageVersion("Seurat")  # 应显示 5.x.x
```

> **👤 小白**：第 2 步报错了！"ERROR: dependency 'Matrix' is not available"

> **🤖 Claude Code 回复**：这是因为 Matrix 包版本不兼容。修复步骤：
> ```r
> # 先更新 Matrix
> install.packages("Matrix", type = "source")
> # 然后重新执行第 2 步
> BiocManager::install(c("SingleCellExperiment", "SummarizedExperiment"), 
>   update = FALSE, ask = FALSE)
> ```

### Seurat 生态常用扩展包

| 包名 | 用途 | Claude 给出的安装命令 |
|------|------|---------------------|
| **SeuratData** | 官方示例数据集 | `remotes::install_github("satijalab/seurat-data")` |
| **SeuratWrappers** | 集成其他工具 | `remotes::install_github("satijalab/seurat-wrappers")` |
| **Azimuth** | 自动细胞注释 | `remotes::install_github("satijalab/azimuth")` |
| **SeuratDisk** | h5ad ↔ Seurat 转换 | `remotes::install_github("mojaveazure/seurat-disk")` |
| **Signac** | 单细胞 ATAC-seq | `BiocManager::install("Signac")` |
| **Harmony** | 批次效应校正 | `remotes::install_github("immunogenomics/harmony")` |
| **DoubletFinder** | 双细胞检测 | `remotes::install_github("chris-mcginnis-uoft/DoubletFinder")` |

> 💡 **Claude 使用技巧**：直接告诉 Claude "我需要做单细胞免疫分析，帮我列出需要安装的所有 R 包"，Claude 会根据你的分析目标自动生成完整的安装列表。

---

## 1.4 Scanpy 单细胞分析生态

### 这是什么？
Scanpy 是 Python 中与 Seurat 对应的单细胞分析工具包，由 Theis 实验室开发。适合熟悉 Python 的用户。

### 完整安装流程

> **👤 小白**：帮我在 conda 环境中安装 Scanpy 和所有常用扩展

> **🤖 Claude Code 回复**：

```bash
# === 第 1 步：创建专用环境 ===
mamba create -n scanpy python=3.10 -y
mamba activate scanpy

# === 第 2 步：安装核心 Scanpy ===
mamba install -c conda-forge scanpy -y

# === 第 3 步：安装常用扩展 ===
mamba install -c conda-forge \
  anndata \
  leidenalg \
  harmonypy \
  scvi-tools \
  scmomat \
  cellxgene-census \
  squidpy \
  -y

# === 第 4 步：pip 安装 Scanpy 生态的高级工具 ===
pip install \
  scvelo \
  cellrank \
  scib \
  scarches \
  decoupler \
  omnipath
```

### 验证安装

```python
# 在 Python 中验证
import scanpy as sc
print(sc.__version__)   # 应显示 1.10.x 或更高

# 测试基础功能
adata = sc.datasets.pbmc3k()  # 下载示例数据
print(adata)                  # 应显示 AnnData 对象信息
```

### Scanpy vs Seurat 选择建议

> **👤 小白**：我应该学 Seurat 还是 Scanpy？

> **🤖 Claude Code 回复**：这取决于你的背景和实验室传统：
> 
> | 场景 | 推荐 |
> |------|------|
> | 实验室用 R | Seurat |
> | 实验室用 Python | Scanpy |
> | 要做深度学习 (scVI, scGPT) | Scanpy (Python 生态) |
> | 要做高级统计 (DESeq2, limma) | Seurat (R 生态) |
> | 零基础 | Seurat（教程更多，社区更大） |
> | 有编程基础 | Scanpy（代码更简洁） |
>
> **最佳策略**：两个都会。用 SeuratDisk 在两者之间转换。

---

## 1.5 Cell Ranger (10x Genomics)

### 这是什么？
Cell Ranger 是 10x Genomics 官方的单细胞数据预处理软件，将 FASTQ 文件处理为基因表达矩阵。

### 前置说明
Cell Ranger 需要 **较大的计算资源**（建议 32GB+ 内存），且官方只提供 Linux 版本。下载需要注册 10x Genomics 账号。

### Claude 辅助安装

> **👤 小白**：怎么在服务器上安装 Cell Ranger 8.0？

> **🤖 Claude Code 回复**：

```bash
# === 第 1 步：下载（需在 10x Genomics 官网获取下载链接） ===
# 访问 https://www.10xgenomics.com/support/software/cell-ranger/downloads
# 获取 tar.gz 下载地址后：
wget -O cellranger-8.0.1.tar.gz "https://cf.10xgenomics.com/releases/cell-exp/cellranger-8.0.1.tar.gz?Expires=..."

# === 第 2 步：解压并添加到 PATH ===
tar -xzf cellranger-8.0.1.tar.gz -C /opt/
echo 'export PATH=/opt/cellranger-8.0.1:$PATH' >> ~/.bashrc
source ~/.bashrc

# === 第 3 步：验证 ===
cellranger --version

# === 第 4 步：下载参考基因组（以人类 GRCh38 为例） ===
# 10x 提供预构建的参考基因组
wget "https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2024-A.tar.gz"
tar -xzf refdata-gex-GRCh38-2024-A.tar.gz -C /opt/references/
```

### 常见问题

> **👤 小白**：cellranger count 跑了两天了还没结束，正常吗？

> **🤖 Claude Code 回复**：这取决于数据和服务器。一个典型的 10x 样本（~5,000 cells, 50K reads/cell）在 32 核 + 128GB 内存的服务器上大约需要 **4-8 小时**。如果超过 24 小时，检查：
> 1. `top` — 确认 CPU 使用率（应接近 100%）
> 2. `htop` — 确认内存没有换入 swap（swap 使用会极大拖慢速度）
> 3. 检查 `_log` 文件 — 看是否有报错或卡在某一步
> 4. 若内存不足，设置 `--localmem` 参数限制内存使用

> **👤 小白**：Cell Ranger 报 "No space left on device"

> **🤖 Claude Code 回复**：Cell Ranger 在运行过程中会产生大量临时文件。解决：
> ```bash
> # 1. 检查磁盘空间
> df -h
> # 2. 清理 Cell Ranger 临时文件
> rm -rf /tmp/cellranger_*
> # 3. 指定临时目录到空间大的磁盘
> cellranger count --id=sample1 \
>   --transcriptome=/opt/references/refdata-gex-GRCh38-2024-A \
>   --fastqs=/data/fastqs \
>   --sample=sample1 \
>   --localcores=32 \
>   --localmem=64 \
>   --tmpdir=/large_disk/tmp    # ← 关键参数
> ```

---

## 1.6 STARsolo

### 这是什么？
STARsolo 是 STAR 比对器的单细胞模式，可以直接从 FASTQ 生成表达矩阵。它是 **DNBelab C4 平台推荐** 的比对工具，也支持 10x 数据。

### Claude 辅助安装

> **👤 小白**：帮我在服务器上安装 STAR (含 STARsolo)

> **🤖 Claude Code 回复**：

```bash
# === 方法一：conda 安装（推荐） ===
mamba create -n starsolo -y
mamba activate starsolo
mamba install -c conda-forge -c bioconda star -y

# === 方法二：从源码编译（最新版本） ===
# 下载
wget https://github.com/alexdobin/STAR/archive/refs/tags/2.7.11b.tar.gz
tar -xzf 2.7.11b.tar.gz
cd STAR-2.7.11b/source

# 编译（根据你的系统选择）
make STAR   # 标准编译
# 或者 make STAR CXXFLAGS_SIMD="-mavx2"   # 支持 AVX2 加速

# 添加到 PATH
sudo cp STAR /usr/local/bin/
STAR --version
```

### STAR 构建参考基因组索引

> **👤 小白**：怎么为 STARsolo 准备参考基因组？

> **🤖 Claude Code 回复**：

```bash
# === 创建 STAR 索引（人类 GRCh38） ===
# 需要：基因组 FASTA + 基因注释 GTF

mkdir -p /opt/references/STAR_GRCh38
STAR --runThreadN 32 \
     --runMode genomeGenerate \
     --genomeDir /opt/references/STAR_GRCh38 \
     --genomeFastaFiles /opt/references/GRCh38.primary_assembly.genome.fa \
     --sjdbGTFfile /opt/references/gencode.v44.primary_assembly.annotation.gtf \
     --sjdbOverhang 100   # 读长-1，150bp 测序设为 100-149

# ⚠️ 注意：构建索引需要约 40-50GB 内存，耗时 1-3 小时
```

---

## 1.7 Kallisto / bustools

### 这是什么？
Kallisto 是超快的伪比对工具，配合 bustools 可以在几分钟内完成单细胞定量。**速度是 Cell Ranger/STAR 的 10-100 倍，内存占用极低。**

### Claude 辅助安装

```bash
# === 安装 kallisto 和 bustools ===
mamba install -c conda-forge -c bioconda kallisto bustools -y

# 验证
kallisto version
bustools version
```

### Kallisto 优势速览

| 对比项 | Cell Ranger / STARsolo | Kallisto + bustools |
|--------|----------------------|---------------------|
| 速度 | 慢（4-8 小时/样本） | 快（5-20 分钟/样本） |
| 内存 | 32-64GB | 4-8GB |
| 精确度 | 高（比对级） | 高（伪比对级） |
| BAM 文件 | 有 | 无 |
| 适用场景 | 需要 BAM 做变异分析 | 只要表达矩阵 |

---

## 1.8 DESeq2 (Bulk RNA-seq 差异分析)

### 这是什么？
DESeq2 是 Bulk RNA-seq 差异表达分析的黄金标准，基于负二项分布模型。

### Claude 辅助安装

```r
# 在 R 中执行
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("DESeq2")

# 验证
library(DESeq2)
packageVersion("DESeq2")
```

### 典型 Claude 使用案例

> **👤 小白**：我有 3 个对照组和 3 个处理组的 counts 矩阵，帮我写 DESeq2 分析代码

> **🤖 Claude Code 回复**：
> ```r
> # 读入数据
> counts <- read.csv("counts_matrix.csv", row.names = 1)
> coldata <- data.frame(
>   condition = factor(c(rep("control", 3), rep("treatment", 3))),
>   row.names = colnames(counts)
> )
> 
> # DESeq2 分析
> library(DESeq2)
> dds <- DESeqDataSetFromMatrix(countData = counts, colData = coldata, 
>                                design = ~ condition)
> dds <- DESeq(dds)
> res <- results(dds, contrast = c("condition", "treatment", "control"))
> 
> # 筛选显著差异基因
> res_sig <- subset(res, padj < 0.05 & abs(log2FoldChange) > 1)
> write.csv(as.data.frame(res_sig), "DEG_results.csv")
> ```

---

## 1.9 Monocle3 (拟时序分析)

### 这是什么？
Monocle3 是单细胞拟时序（pseudotime / trajectory）分析工具，可以推断细胞分化/发育轨迹。

### Claude 辅助安装

```r
# Monocle3 依赖较多，建议分步安装
install.packages("remotes")
BiocManager::install(c(
  "BiocGenerics", "DelayedArray", "DelayedMatrixStats",
  "limma", "lme4", "S4Vectors", "SingleCellExperiment",
  "SummarizedExperiment", "batchelor", "HDF5Array",
  "terra", "ggrastr"
))

# 安装 Monocle3
remotes::install_github("cole-trapnell-lab/monocle3")

# 验证
library(monocle3)
```

### 常见安装问题

> **👤 小白**：Monocle3 安装报错 "terra not available"

> **🤖 Claude Code 回复**：terra 包需要系统级依赖。先执行：
> ```bash
> sudo apt install libgdal-dev libgeos-dev libproj-dev -y
> ```
> 然后在 R 中：
> ```r
> install.packages("terra")
> # 如果还是不行，从 conda 安装 R 和 terra：
> # mamba install -c conda-forge r-terra -y
> ```

---

## 1.10 CellChat (细胞通讯分析)

### 这是什么？
CellChat 通过配体-受体数据库推断细胞间通讯网络。是单细胞领域最流行的细胞通讯分析工具之一。

### Claude 辅助安装

```r
# 依赖
install.packages("remotes")
install.packages(c("NMF", "circlize", "ggalluvial"))

# CellChat 本体
remotes::install_github("jinworks/CellChat")

# 验证
library(CellChat)
```

### 常见问题

> **👤 小白**：CellChat 报错 "NMF not available"

> **🤖 Claude Code 回复**：NMF 包在某些系统上需要额外配置：
> ```r
> # 方法 1：从 Bioconductor 安装
> BiocManager::install("NMF")
> 
> # 方法 2：从 conda 安装 R + NMF
> # mamba install -c conda-forge r-nmf -y
> 
> # 方法 3：如果还是不行，用 RANN 替代（CellChat 的新版本支持）
> install.packages("RANN")
> ```

---

## 1.11 SCENIC / pySCENIC (转录因子调控网络)

### 这是什么？
SCENIC (Single-Cell rEgulatory Network Inference and Clustering) 推断每个细胞的转录因子活性，揭示基因调控网络。

### Claude 辅助安装

> **👤 小白**：帮我安装 pySCENIC（Python 版本，比 R 版本更快）

> **🤖 Claude Code 回复**：

```bash
mamba create -n pyscenic python=3.10 -y
mamba activate pyscenic

# 安装 pySCENIC
pip install pyscenic

# 安装辅助工具（用于 cisTarget 数据库）
pip install ctxcore

# 验证
pyscenic --version
```

### pySCENIC 需要下载的数据库文件（Claude 会帮你列出）

> **🤖 Claude Code 回复**：
> ```bash
> # 下载人类参考数据库（约 500MB）
> mkdir -p ~/scenic_db/human
> cd ~/scenic_db/human
> 
> # 1. TF 列表
> wget https://resources.aertslab.org/cistarget/tf_lists/allTFs_hg38.txt
> 
> # 2. 调控特征数据库
> wget https://resources.aertslab.org/cistarget/databases/homo_sapiens/hg38/refseq_r80/mc9nr/gene_based/hg38__refseq-r80__10kb_up_and_down_tss.mc9nr.genes_vs_motifs.rankings.feather
> 
> # 3. Motif 注释
> wget https://resources.aertslab.org/cistarget/motif2tf/motifs-v9-nr.hgnc-m0.001-o0.0.tbl
> ```

> **👤 小白**：内存不够怎么办？

> **🤖 Claude Code 回复**：pySCENIC 的 GRNBoost2 步骤比较耗内存。优化策略：
> ```bash
> # 1. 限制线程数
> pyscenic grn --num_workers 4 ...
> 
> # 2. 对大数据集采用分块处理
> pyscenic grn --chunk_size 1000 ...
> 
> # 3. 使用子采样细胞（如果细胞数 > 50K）
> ```

---

## 1.12 MACS2 (ATAC-seq 峰调用)

### 这是什么？
MACS2 是 ChIP-seq / ATAC-seq 中峰调用的标准工具。

```bash
# conda 安装
mamba install -c conda-forge -c bioconda macs2 -y

# 验证
macs2 --version
```

---

## 1.13 ArchR / Signac (单细胞 ATAC-seq)

### 选择建议

| 工具 | 语言 | 特点 | 谁该用 |
|------|------|------|--------|
| **Signac** | R | 与 Seurat 无缝集成 | 已有 Seurat 基础的 |
| **ArchR** | R | 功能全面、性能好 | 深度 ATAC-seq 分析 |

### Signac 安装

```r
BiocManager::install("Signac")
# 验证
library(Signac)
```

### ArchR 安装（Claude 对话）

> **👤 小白**：帮我装 ArchR

> **🤖 Claude Code 回复**：
> ```r
> # ArchR 需要 devtools
> install.packages("devtools")
> 
> # 从 GitHub 安装
> devtools::install_github("GreenleafLab/ArchR", ref="master", repos = BiocManager::repositories())
> 
> # 如果报错 "Cairo not available"
> # 先在 bash 中安装：sudo apt install libcairo2-dev -y
> # 然后重新安装
> 
> # 验证
> library(ArchR)
> ```

---

## 1.14 其他常用工具速装

> 💡 **Claude 使用技巧**：直接把下面的表格截图发给 Claude Code，问"帮我安装这些工具，生成一个一键脚本"。

| 工具 | 安装命令 | 用途 |
|------|---------|------|
| **Harmony** | `remotes::install_github("immunogenomics/harmony")` | 批次效应校正 |
| **scVI** | `pip install scvi-tools` | 深度学习批次校正 |
| **inferCNV** | `remotes::install_github("broadinstitute/inferCNV")` | 拷贝数变异 |
| **CopyKAT** | `remotes::install_github("navinlabcode/copykat")` | 拷贝数变异 |
| **CytoTRACE** | `remotes::install_github("digitalcytometry/cytotrace2")` | 干性评估 |
| **Slingshot** | `BiocManager::install("slingshot")` | 拟时序 |
| **scVelo** | `pip install scvelo` | RNA velocity |
| **NicheNet** | `remotes::install_github("saeyslab/nichenetr")` | 细胞通讯 |
| **enrichR** | `install.packages("enrichR")` | 富集分析 |
| **clusterProfiler** | `BiocManager::install("clusterProfiler")` | GO/KEGG 富集 |
| **EnhancedVolcano** | `BiocManager::install("EnhancedVolcano")` | 火山图 |
| **ComplexHeatmap** | `BiocManager::install("ComplexHeatmap")` | 复杂热图 |
| **ggplot2** | `install.packages("ggplot2")` | 绑图基础 |
| **tidyverse** | `install.packages("tidyverse")` | 数据处理全家桶 |

---

# 第二篇：示范数据测试篇

> **核心理念**：你不必等到有自己的数据才开始学习——Claude Code 可以带你用公开示范数据，完整走通每个工具的分析流程。

---

## 2.1 Seurat 官方 pbmc3k 教程

### 这是什么？
PBMC 3k 是 10x Genomics 提供的公开数据集，包含 2,700 个外周血单个核细胞。**这是全球最经典的单细胞入门数据集。**

### 完整学习流程（Claude 对话实录）

> **👤 小白**：我想用 Seurat 分析 pbmc3k 数据，请一步步教我

> **🤖 Claude Code 回复**：好的，以下是完整的 Seurat 标准分析流程。

```r
# ==========================================
# 🧬 Seurat 标准流程：PBMC 3k 教程
# ==========================================

library(Seurat)
library(dplyr)
library(ggplot2)

# === 第 1 步：下载并读入数据 ===
# 下载 pbmc3k 数据
pbmc_url <- "https://cf.10xgenomics.com/samples/cell/pbmc3k/pbmc3k_filtered_gene_bc_matrices.tar.gz"
download.file(pbmc_url, destfile = "pbmc3k.tar.gz")
untar("pbmc3k.tar.gz")

# 读入数据
pbmc.data <- Read10X(data.dir = "filtered_gene_bc_matrices/hg19")
pbmc <- CreateSeuratObject(counts = pbmc.data, project = "pbmc3k", 
                            min.cells = 3, min.features = 200)
pbmc
# 应显示：2700 cells x 13714 genes

# === 第 2 步：QC ===
# 计算线粒体基因比例
pbmc[["percent.mt"]] <- PercentageFeatureSet(pbmc, pattern = "^MT-")

# 查看 QC 指标
VlnPlot(pbmc, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), 
        ncol = 3, pt.size = 0.1)

# 过滤
pbmc <- subset(pbmc, subset = nFeature_RNA > 200 & nFeature_RNA < 2500 & percent.mt < 5)

# === 第 3 步：归一化和高变基因 ===
pbmc <- NormalizeData(pbmc, normalization.method = "LogNormalize", scale.factor = 10000)
pbmc <- FindVariableFeatures(pbmc, selection.method = "vst", nfeatures = 2000)

# 标记 top10 高变基因
top10 <- head(VariableFeatures(pbmc), 10)
VariableFeaturePlot(pbmc) + LabelPoints(points = top10, repel = TRUE)

# === 第 4 步：缩放和 PCA ===
all.genes <- rownames(pbmc)
pbmc <- ScaleData(pbmc, features = all.genes)
pbmc <- RunPCA(pbmc, features = VariableFeatures(object = pbmc))

# 检查 PCA 结果
ElbowPlot(pbmc, ndims = 50)

# === 第 5 步：聚类 ===
pbmc <- FindNeighbors(pbmc, dims = 1:10)
pbmc <- FindClusters(pbmc, resolution = 0.5)

# === 第 6 步：UMAP ===
pbmc <- RunUMAP(pbmc, dims = 1:10)
DimPlot(pbmc, reduction = "umap", label = TRUE) + NoLegend()

# === 第 7 步：找差异基因 ===
pbmc.markers <- FindAllMarkers(pbmc, only.pos = TRUE, 
                                logfc.threshold = 0.25, min.pct = 0.25)
top5 <- pbmc.markers %>% group_by(cluster) %>% top_n(n = 5, wt = avg_log2FC)

# 热图
DoHeatmap(pbmc, features = top5$gene) + NoLegend()

# === 第 8 步：细胞注释 ===
# 经典 PBMC marker：
# B 细胞: MS4A1 (CD20), CD79A
# CD4+ T 细胞: CD3D, CD4
# CD8+ T 细胞: CD3D, CD8A
# NK 细胞: NKG7, GNLY
# 单核细胞: CD14, LYZ
# 树突状细胞: FCER1A, CST3

FeaturePlot(pbmc, features = c("MS4A1", "CD3D", "CD14", "NKG7", "CD8A"))

# 手动注释
new.cluster.ids <- c(
  "Naive CD4 T",    # 0
  "CD14+ Mono",     # 1
  "Memory CD4 T",   # 2
  "B",              # 3
  "CD8 T",          # 4
  "FCGR3A+ Mono",   # 5
  "NK",             # 6
  "DC",             # 7
  "Platelet"        # 8
)
names(new.cluster.ids) <- levels(pbmc)
pbmc <- RenameIdents(pbmc, new.cluster.ids)

# 最终 UMAP
DimPlot(pbmc, reduction = "umap", label = TRUE, pt.size = 0.5) + NoLegend()
```

### 常见问题（Claude 帮你解决）

> **👤 小白**：`Read10X` 报错 "Directory does not contain the required files"

> **🤖 Claude Code 回复**：解压后确认目录结构。应该有三个文件：`barcodes.tsv.gz`、`features.tsv.gz`、`matrix.mtx.gz`。如果文件命名不同：
> ```r
> list.files("filtered_gene_bc_matrices/hg19", recursive = TRUE)
> ```

> **👤 小白**：`RunPCA` 报了内存错误

> **🤖 Claude Code 回复**：pbmc3k 很小，理论上不会内存不足。检查：
> 1. 是否有其他程序占用内存（`htop`）
> 2. 重启 R session 再试
> 3. 如果服务器内存<4GB，考虑在本地电脑上跑 pbmc3k

---

## 2.2 Scanpy 官方 pbmc3k 教程

```python
# ==========================================
# 🧬 Scanpy 标准流程：PBMC 3k 教程
# ==========================================

import scanpy as sc
import pandas as pd
import matplotlib.pyplot as plt

# === 第 1 步：下载并加载数据 ===
adata = sc.datasets.pbmc3k()
print(adata)  # 2700 × 32738

# === 第 2 步：QC ===
adata.var['mt'] = adata.var_names.str.startswith('MT-')
sc.pp.calculate_qc_metrics(adata, qc_vars=['mt'], percent_top=None, log1p=False, inplace=True)

# 过滤
sc.pp.filter_cells(adata, min_genes=200)
sc.pp.filter_genes(adata, min_cells=3)
adata = adata[adata.obs.n_genes_by_counts < 2500, :]
adata = adata[adata.obs.pct_counts_mt < 5, :]

# === 第 3 步：归一化和高变基因 ===
sc.pp.normalize_total(adata, target_sum=1e4)
sc.pp.log1p(adata)
sc.pp.highly_variable_genes(adata, n_top_genes=2000)
adata.raw = adata  # 保存原始数据

# === 第 4 步：缩放和 PCA ===
sc.pp.scale(adata, max_value=10)
sc.tl.pca(adata, svd_solver='arpack')

# === 第 5 步：聚类 ===
sc.pp.neighbors(adata, n_pcs=10)
sc.tl.umap(adata)
sc.tl.leiden(adata, resolution=0.5)

# === 第 6 步：可视化 ===
sc.pl.umap(adata, color='leiden', legend_loc='on data', title='PBMC 3k Leiden Clusters')

# === 第 7 步：找 marker 基因 ===
sc.tl.rank_genes_groups(adata, 'leiden', method='wilcoxon')
sc.pl.rank_genes_groups_heatmap(adata, n_genes=5, groupby='leiden')

# === 第 8 步：注释 ===
marker_dict = {
    'CD14+ Mono': ['CD14', 'LYZ'],
    'FCGR3A+ Mono': ['FCGR3A', 'MS4A7'],
    'CD4 T': ['CD3D', 'CD4'],
    'CD8 T': ['CD3D', 'CD8A'],
    'B': ['CD79A', 'MS4A1'],
    'NK': ['GNLY', 'NKG7'],
    'DC': ['FCER1A', 'CST3'],
}
sc.pl.dotplot(adata, marker_dict, groupby='leiden')
```

### Scanpy 常见问题

> **👤 小白**：`sc.datasets.pbmc3k()` 下载很慢

> **🤖 Claude Code 回复**：这个函数从 GitHub 下载，国内可能需要代理。替代方法：
> ```python
> # 手动下载并加载
> # 1. 从浏览器下载：https://cf.10xgenomics.com/samples/cell/pbmc3k/pbmc3k_filtered_gene_bc_matrices.tar.gz
> # 2. 解压后用 scanpy 加载
> adata = sc.read_10x_mtx('filtered_gene_bc_matrices/hg19/', var_names='gene_symbols', cache=True)
> ```

---

## 2.3 Cell Ranger 官方 small dataset

### 10x 官方提供的小数据集用于测试

```bash
# === 下载测试数据（约 300MB，比实际数据小很多） ===
# 参考基因组
wget https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2024-A.tar.gz
tar -xzf refdata-gex-GRCh38-2024-A.tar.gz

# 测试 FASTQ（约 200MB）
wget https://cf.10xgenomics.com/samples/cell-exp/10.0.0/pbmc_1k_v3/pbmc_1k_v3_fastqs.tar
tar -xf pbmc_1k_v3_fastqs.tar

# === 运行测试 ===
cellranger count --id=test_pbmc1k \
    --transcriptome=refdata-gex-GRCh38-2024-A \
    --fastqs=pbmc_1k_v3_fastqs \
    --sample=pbmc_1k_v3 \
    --localcores=8 \
    --localmem=16
```

> **👤 小白**：这个测试需要多久？

> **🤖 Claude Code 回复**：在 8 核 + 16GB 内存的服务器上大约 **30-60 分钟**。如果超过 2 小时，用 `htop` 检查资源使用情况，确认没有 swap 开销。

---

## 2.4 Bulk RNA-seq 示例 (airway 数据集)

### 使用 R 内置的 airway 数据集学习 DESeq2

```r
# ==========================================
# 🧬 DESeq2 入门：airway 数据集分析
# ==========================================

# 安装并加载 airway 数据包
BiocManager::install("airway")
library(airway)
library(DESeq2)

# 加载数据
data("airway")
airway
# 4 个 dex 处理组 + 4 个对照组（共 8 个样本）

# DESeq2 分析
dds <- DESeqDataSet(airway, design = ~ cell + dex)
dds <- DESeq(dds)

# 结果
res <- results(dds, contrast = c("dex", "trt", "untrt"))
res <- res[order(res$pvalue), ]
summary(res)

# 火山图
library(EnhancedVolcano)
EnhancedVolcano(res, lab = rownames(res),
                x = 'log2FoldChange', y = 'pvalue',
                title = 'Dexamethasone treatment vs Control',
                pCutoff = 0.05, FCcutoff = 1.0)
```

---

## 2.5 单细胞 ATAC-seq 示例

### 使用 Signac 提供的 PBMC ATAC 示例数据

```r
# ==========================================
# 🧬 Signac + Seurat：scATAC-seq 入门
# ==========================================
library(Signac)
library(Seurat)

# 下载示例数据 (PBMC Multiome: RNA + ATAC)
# 下载链接：https://www.10xgenomics.com/resources/datasets/pbmc-from-a-healthy-donor-granulocytes-removed-through-cell-sorting-10-k-2-standard-2-0-0
counts <- Read10X_h5("pbmc_granulocyte_sorted_10k_filtered_feature_bc_matrix.h5")

# 创建 Seurat 对象
pbmc <- CreateSeuratObject(counts = counts$`Gene Expression`, project = "pbmc_atac")

# 创建 ATAC assay
pbmc[["ATAC"]] <- CreateChromatinAssay(
  counts = counts$Peaks,
  sep = c(":", "-"),
  genome = "hg38"
)

# ATAC QC
pbmc <- NucleosomeSignal(pbmc)
pbmc <- TSSEnrichment(pbmc)
```

---

## 2.6 CellChat 示例数据

```r
# ==========================================
# 🧬 CellChat 入门示例
# ==========================================
library(CellChat)
library(Seurat)

# 使用 CellChat 自带的示例数据
# 方法：从已有的 Seurat 对象开始（比如上面的 pbmc3k）
# 先跑完 Seurat 标准流程，然后：

# 创建 CellChat 对象
cellchat <- createCellChat(object = pbmc, group.by = "ident")

# 设置配体-受体数据库
CellChatDB <- CellChatDB.human
CellChatDB.use <- subsetDB(CellChatDB, search = "Secreted Signaling")
cellchat@DB <- CellChatDB.use

# 预处理
cellchat <- subsetData(cellchat)
cellchat <- identifyOverExpressedGenes(cellchat)
cellchat <- identifyOverExpressedInteractions(cellchat)
cellchat <- projectData(cellchat, PPI.human)

# 推断通讯网络
cellchat <- computeCommunProb(cellchat)
cellchat <- filterCommunication(cellchat, min.cells = 10)
cellchat <- computeCommunProbPathway(cellchat)
cellchat <- aggregateNet(cellchat)

# 可视化
netVisual_circle(cellchat@net$count, vertex.weight = groupSize)
```

---

## 2.7 Monocle3 拟时序示例

```r
# ==========================================
# 🧬 Monocle3 入门：拟时序分析
# ==========================================

library(monocle3)
library(SeuratWrappers)

# 方法 1：从 Seurat 对象转换（推荐）
# 假设 pbmc 是已跑完 Seurat 流程的对象
cds <- as.cell_data_set(pbmc)

# 方法 2：使用 Monocle3 自带示例数据
# 下载 Cajal 小体发育数据（约 600 细胞，适合入门）
cds <- load_A549()

# === 标准拟时序流程 ===
# 预处理
cds <- preprocess_cds(cds, num_dim = 50)
cds <- reduce_dimension(cds)
cds <- cluster_cells(cds, resolution = 1e-3)

# 可视化
plot_cells(cds, color_cells_by = "cluster", label_cell_groups = FALSE)

# 学习轨迹
cds <- learn_graph(cds)

# 拟时序排序
cds <- order_cells(cds)

# 最终可视化
plot_cells(cds,
           color_cells_by = "pseudotime",
           label_cell_groups = FALSE,
           label_leaves = FALSE,
           label_branch_points = FALSE)

# 找随拟时序变化的基因
pr_test_res <- graph_test(cds, neighbor_graph = "principal_graph", cores = 4)
pr_deg_ids <- row.names(subset(pr_test_res, q_value < 0.05))

# 热图
plot_genes_in_pseudotime(cds[pr_deg_ids[1:10], ],
                         color_cells_by = "pseudotime",
                         min_expr = 0.5)
```

---

# 第三篇：报错解决篇

> **核心理念**：报错不可怕——把报错信息直接粘贴给 Claude Code，它会告诉你原因和解决方案。

---

## 3.1 环境安装类错误

### 错误 1：conda 创建环境超时

```
CondaHTTPError: HTTP 000 CONNECTION FAILED
```

> **🤖 Claude Code 诊断**：conda 的默认源在国外，国内用户经常会超时。

**修复方案**：
```bash
# 换清华镜像源
cat > ~/.condarc << 'EOF'
channels:
  - conda-forge
  - bioconda
  - defaults
show_channel_urls: true
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
custom_channels:
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
EOF

mamba clean -i  # 清理缓存
mamba install -c conda-forge 你要的包名  # 重新尝试
```

### 错误 2：R 包安装报 "non-zero exit status"

```
ERROR: compilation failed for package 'xxx'
* removing '/home/user/R/x86_64-pc-linux-gnu-library/4.3/xxx'
```

> **🤖 Claude Code 诊断**：包在编译 C/C++/Fortran 源码时失败了，通常是缺少系统依赖库。

**修复流程**：
```
👤 小白：粘贴完整报错信息（特别是最后的 ERROR 行）
🤖 Claude Code：
  1. 识别缺少哪个系统库
  2. 生成 sudo apt install 命令
  3. 在 R 中重新安装
```

**常见缺失的库**：

| R 包 | 缺失症状 | 安装命令 |
|------|---------|---------|
| `sf` | gdal-config not found | `sudo apt install libgdal-dev -y` |
| `curl` | curl/curl.h not found | `sudo apt install libcurl4-openssl-dev -y` |
| `xml2` | libxml2 not found | `sudo apt install libxml2-dev -y` |
| `openssl` | openssl/ssl.h not found | `sudo apt install libssl-dev -y` |
| `Rcpp` | g++ not found | `sudo apt install build-essential -y` |
| `magick` | Magick++ not found | `sudo apt install libmagick++-dev -y` |
| `hdf5r` | hdf5.h not found | `sudo apt install libhdf5-dev -y` |

---

## 3.2 内存不足类错误

### 错误 3：R 报 "cannot allocate vector of size X Gb"

```
Error: cannot allocate vector of size 2.5 Gb
```

> **🤖 Claude Code 诊断**：R 尝试分配一块大于可用内存的空间。单细胞数据（尤其是几十万细胞）很容易触发这个问题。

**分级修复方案**：

```r
# 方案 1：检查当前内存使用
gc()               # 报告内存使用情况
# Linux: 在 shell 中 system("free -h")

# 方案 2：清理不用的对象
rm(list = setdiff(ls(), "pbmc"))  # 只保留需要的数据
gc()

# 方案 3：对大矩阵使用稀疏格式（大幅降低内存）
counts_sparse <- as(counts, "dgCMatrix")

# 方案 4：降采样
set.seed(42)
cells_to_keep <- sample(colnames(pbmc), 10000)
pbmc_subset <- subset(pbmc, cells = cells_to_keep)

# 方案 5：分析后立刻保存和清理
saveRDS(pbmc, "pbmc_processed.rds")
rm(pbmc); gc()
```

**对于 Cell Ranger / STARsolo**：
```bash
# 控制在可用内存的 80% 以内
cellranger count --localmem=64  # 明确指定使用 64GB
```

### 错误 4：STAR 索引构建时 killed

```
Killed
```

> **🤖 Claude Code 诊断**：系统 OOM Killer 杀掉了 STAR 进程。STAR 索引构建需要 40-50GB 内存。

**修复**：
```bash
# 1. 增加 swap（临时方案）
sudo fallocate -l 100G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# 2. 限制 STAR 线程（线程越多内存消耗越大）
STAR --runThreadN 8 --runMode genomeGenerate ...  # 不要用 32 线程

# 3. 用较小的基因组（如只选 primary assembly）
```

---

## 3.3 数据格式/类型错误

### 错误 5：Seurat 对象类型错误

```
Error in UseMethod(generic = "FetchData", object = object) :
  no applicable method for 'FetchData' applied to an object of class "list"
```

> **🤖 Claude Code 诊断**：你把一个 list 当作 Seurat 对象传给了函数。可能是在某个步骤中意外把 Seurat 对象变成了其他类型。

**排查**：
```r
class(pbmc)  # 应该返回 "Seurat"
# 如果返回 "list"，说明对象被破坏了
# 解决：回到上一步重建 Seurat 对象
```

### 错误 6：counts matrix 格式问题

```
Error in DESeqDataSetFromMatrix: some values in assay are not integers
```

> **🤖 Claude Code 诊断**：DESeq2 需要整数 counts，但你的矩阵中有小数。

**修复**：
```r
# 检查数据类型
class(counts[1,1])  # 应该是 integer

# 如果不是整数，取整
counts <- round(counts)
# 或者
counts <- ceiling(counts)

# 如果是归一化后的数据而非原始 counts
# → 需要用原始 counts 矩阵，不能用 TPM/FPKM
```

---

## 3.4 包版本兼容性错误

### 错误 7：Seurat v4 代码在 Seurat v5 中报错

```
Error: 'FindVariableFeatures' is not an exported object from 'namespace:Seurat'
# （Seurat v5 中部分函数名或参数有变化）
```

> **🤖 Claude Code 诊断**：Seurat v5 有大量 API 变化。

**区别速查**：

| Seurat v4 | Seurat v5 | 
|-----------|-----------|
| `pbmc[["RNA"]]@data` | `GetAssayData(pbmc, assay = "RNA", layer = "data")` |
| `pbmc[["RNA"]]@counts` | `GetAssayData(pbmc, assay = "RNA", layer = "counts")` |
| 多层数据 | `JoinLayers(pbmc, assay = "RNA")` 合并后再操作 |

**解决**：
```r
# 在脚本开头检查版本
if (packageVersion("Seurat") >= "5.0.0") {
  message("使用 Seurat v5 语法")
  pbmc <- JoinLayers(pbmc)  # 合并多层
}
```

### 错误 8：Matrix 包版本冲突

```
Error: package or namespace load failed for 'Seurat':
 object 'ambig_rownames_matches_checked' is not exported by 'namespace:Matrix'
```

> **🤖 Claude Code 诊断**：Matrix 包版本太旧或太新。

**修复**：
```r
# 安装兼容版本
install.packages("Matrix", version = "1.6-5", repos = "https://cran.r-project.org")
# 或从源码安装
install.packages("Matrix", type = "source")
```

---

## 3.5 文件路径/权限错误

### 错误 9：文件找不到

```
Error: Cannot open file 'counts.csv': No such file or directory
```

> **🤖 Claude Code 诊断**：R/Python 的当前工作目录与你以为的不同。

**修复**：
```r
# 在 R 中
getwd()                     # 查看当前工作目录
setwd("/home/user/project") # 设置正确路径
list.files()                # 列出文件确认

# 推荐使用绝对路径
counts <- read.csv("/home/user/project/data/counts.csv")
```

### 错误 10：权限被拒绝

```
Error: Permission denied
```

> **🤖 Claude Code 诊断**：可能是文件权限问题，也可能是目录没有写权限。

**修复**：
```bash
# 检查文件权限
ls -la 文件名

# 修改权限
chmod +r 文件名        # 添加读权限
chmod +w 目录名        # 添加写权限
# 或
sudo chown $USER:$USER 文件名   # 修改所有权
```

---

## 3.6 Seurat/Scanpy 专项错误

### 错误 11：NormalizeData 后 FindVariableFeatures 报错

```
Error in FindVariableFeatures: Assay data is not normalized
```

> **🤖 Claude Code 诊断**：先运行 `NormalizeData` 再运行 `FindVariableFeatures`。Seurat v5 中如果数据有多层，先 `JoinLayers`。

### 错误 12：ScaleData 报内存错误

```
Error: vector memory exhausted (limit reached?)
```

> **🤖 Claude Code 诊断**：你的数据太大。优化：
> ```r
> # 只对高变基因运行 ScaleData（最常用，大幅降低内存）
> pbmc <- ScaleData(pbmc, features = VariableFeatures(pbmc))
> 
> # 如果细胞数 > 50K，考虑使用 SCTransform
> pbmc <- SCTransform(pbmc, vars.to.regress = "percent.mt")
> ```

### 错误 13：UMAP 报错

```
Error in RunUMAP: Cannot find 'python' or 'umap-learn'
```

> **🤖 Claude Code 诊断**：Seurat v5 的 UMAP 依赖 Python umap-learn 包。
> ```bash
> pip install umap-learn
> ```
> 或在 R 中：
> ```r
> install.packages("uwot")  # 使用 uwot 后端（纯 R，不依赖 Python）
> pbmc <- RunUMAP(pbmc, dims = 1:10, umap.method = "uwot")
> ```

---

## 3.7 比对/定量工具错误

### 错误 14：Cell Ranger "No reads found"

```
[error] No reads were found. Please check that the input FASTQ files are correct.
```

> **🤖 Claude Code 诊断**：最常见的原因是 `--sample` 参数与 FASTQ 文件名前缀不匹配。
> ```bash
> # FASTQ 文件命名格式必须是： [Sample Name]_S1_L00[Lane]_[Read Type]_001.fastq.gz
> # 例如：pbmc1k_S1_L001_R1_001.fastq.gz
> # 那么 --sample 参数应该是 pbmc1k
> 
> # 检查 FASTQ 文件名
> ls fastq_dir/
> # 确保 --sample 值与文件名前缀匹配
> ```

### 错误 15：STAR "EXITING because of FATAL ERROR"

```
FATAL ERROR: number of bytes expected from the BAM bin does not match
Solution: re-generate genome from scratch
```

> **🤖 Claude Code 诊断**：STAR 索引可能需要重新生成。这通常发生在：
> - 索引是用不同版本的 STAR 构建的
> - 索引文件损坏
> ```bash
> # 删除旧索引重建
> rm -rf /path/to/STAR_index/*
> STAR --runMode genomeGenerate ...  # 重新构建
> ```

---

## 3.8 网络/下载错误

### 错误 16：GitHub 下载失败

```
Error: Failed to install 'Seurat' from GitHub:
 Timeout was reached: [api.github.com] Connection timed out
```

> **🤖 Claude Code 诊断**：国内访问 GitHub 可能不稳定。解决：
> ```r
> # 方法 1：设置代理（如果有）
> Sys.setenv(http_proxy = "http://127.0.0.1:7890")
> Sys.setenv(https_proxy = "http://127.0.0.1:7890")
> 
> # 方法 2：下载 .tar.gz 本地安装
> # 从 GitHub Release 页面下载，然后：
> remotes::install_local("包名.tar.gz")
> ```

### 错误 17：Bioconductor 安装超时

```
Error in download.file(...): Timeout of 60 seconds was reached
```

> **🤖 Claude Code 诊断**：设置更长的超时时间，或换镜像：
> ```r
> options(timeout = 600)  # 10 分钟超时
> 
> # 换清华 Bioconductor 镜像
> options(BioC_mirror = "https://mirrors.tuna.tsinghua.edu.cn/bioconductor")
> ```

---


# 第四篇：GitHub 高端组学分析包实战

> **核心理念**：GitHub 上汇聚了组学领域最前沿的分析工具——它们往往比 CRAN/Bioconductor/PyPI 上的包更新、更强、功能更全。但这些包通常缺少详细文档、依赖链复杂、安装报错频繁。**Claude Code 会成为你的"GitHub 包私人安装顾问"**，从分析 README 到逐个击破依赖，再到跑通示范数据，全程陪伴。

---

## 4.1 为什么 GitHub 组学包让人头疼？

| 痛点 | 具体表现 | Claude Code 如何帮你 |
|------|---------|---------------------|
| **依赖地狱** | 一个包依赖 20+ 个其他包，每个又有版本要求 | 逐层解析依赖链，生成安装脚本 |
| **编译失败** | C/C++/Fortran 源码缺少系统库 | 识别缺失的 `.h` 文件，生成 `apt install` |
| **文档简陋** | README 只有几行，没有详细安装步骤 | Claude 替你解读 README + GitHub Issues |
| **版本敏感** | 包 A 要求 R ≥ 4.4，包 B 要求 Matrix ≤ 1.6 | 版本冲突诊断 + 解决方案 |
| **平台差异** | Linux 可装但 macOS 报错（或反过来） | 根据你的系统自动调整命令 |
| **无人维护** | 原作者已放弃，Issue 没人回 | Claude 分析源码，找到替代方案 |

> 💡 **核心策略**：把 GitHub 包安装变成标准化的 5 步流程，每一步都有 Claude 把关。

---

## 4.2 Claude 辅助 GitHub 包安装：通用 5 步法

### 第 1 步：环境侦察

> **👤 小白**：帮我在当前服务器上准备一个安装 GitHub 组学包的环境

> **🤖 Claude Code** 会先侦查你的系统：
> ```bash
> # Claude 帮你检查系统状态
> lsb_release -a          # 操作系统版本
> R --version             # R 版本
> gcc --version           # 编译器版本
> which cmake             # 是否有 cmake
> df -h /home             # 磁盘空间
> free -h                 # 内存
> ```

### 第 2 步：读取 GitHub 仓库信息

> **👤 小白**：帮我分析这个 GitHub 包的安装要求 https://github.com/GreenleafLab/ArchR

> **🤖 Claude Code** 会：
> 1. 分析 README.md 中的安装说明
> 2. 检查 DESCRIPTION 文件中的依赖列表
> 3. 浏览近期 Issues 中的安装问题
> 4. 输出完整的依赖清单和潜在坑点

### 第 3 步：生成安装脚本

> **🤖 Claude Code** 会生成分步安装脚本，每步都有验证：
> ```bash
> # Claude 生成的脚本结构：
> # Step 1: 系统依赖 → 验证
> # Step 2: R/conda 依赖 → 验证
> # Step 3: GitHub 包本体 → 验证
> # Step 4: 载入测试 → 验证
> ```

### 第 4 步：逐步执行 + 报错修复

> Claude 不会一次性给你 100 行脚本然后不管。而是：
> ```
> 👤 执行第 1 步...报错了！
> 🤖 分析报错 → 给出修复方案 → 重新执行
> 👤 第 1 步通过！
> 🤖 好的，现在执行第 2 步...
> ```

### 第 5 步：示范数据验证

> ```r
> # Claude 会从包的 vignette/test 目录中找到示范数据
> # 生成完整代码帮你验证安装成功
> ```

---

## 4.3 GitHub 高端组学包安装实战

---

### 4.3.1 ArchR — 单细胞 ATAC-seq 全能分析

**GitHub**: https://github.com/GreenleafLab/ArchR  
**用途**: scATAC-seq 全流程分析（QC、降维、聚类、峰注释、TF footprint、基因活性评分）  
**难度**: ⭐⭐⭐⭐（依赖复杂，R 版本敏感）

#### 安装前侦察

> **👤 小白**：帮我装 ArchR，我的系统是 Ubuntu 22.04，R 4.3

> **🤖 Claude Code**：ArchR 是最全面的 scATAC-seq 分析工具，但安装比较挑剔。让我先帮你分析依赖链。

**完整依赖清单（Claude 自动分析）**：

| 层级 | 依赖 | 来源 |
|------|------|------|
| 系统 | `libcairo2-dev`, `libgdal-dev`, `libproj-dev`, `libgeos-dev` | apt |
| R 基础 | `devtools`, `BiocManager` | CRAN |
| Bioc 核心 | `GenomicRanges`, `GenomeInfoDb`, `Rsamtools`, `rtracklayer`, `BSgenome` | Bioconductor |
| Bioc 扩展 | `ComplexHeatmap`, `motifmatchr`, `chromVAR`, `TFBSTools` | Bioconductor |
| GitHub 依赖 | `nabor` (jefferis/nabor) | GitHub |
| 本体 | `ArchR` | GitHub |

#### Claude 辅助安装脚本

```bash
#!/bin/bash
# ==========================================
# 🧬 ArchR 完整安装脚本（Ubuntu 22.04 + R 4.3+）
# Claude Code 生成，每步独立验证
# ==========================================

# ===== 第 1 步：系统依赖 =====
echo "=== Step 1: 系统依赖 ==="
sudo apt update
sudo apt install -y \
  libcairo2-dev \
  libgdal-dev \
  libgeos-dev \
  libproj-dev \
  libxml2-dev \
  libssl-dev \
  libcurl4-openssl-dev \
  libfontconfig1-dev \
  libharfbuzz-dev \
  libfribidi-dev \
  libfreetype6-dev \
  libpng-dev \
  libtiff5-dev \
  libjpeg-dev \
  build-essential \
  cmake

echo "✅ 系统依赖安装完成"
```

```r
# ===== 第 2 步：R 包依赖（在 R 中执行）=====
cat("\n=== Step 2: R 基础依赖 ===\n")

# 安装 devtools 和 BiocManager
install.packages(c("devtools", "BiocManager"), repos = "https://cran.r-project.org")

# 安装 Bioconductor 核心依赖
BiocManager::install(c(
  "GenomicRanges", "GenomeInfoDb", "Rsamtools", "rtracklayer",
  "BSgenome", "BSgenome.Hsapiens.UCSC.hg38", "Biostrings",
  "ComplexHeatmap", "motifmatchr", "chromVAR", "TFBSTools",
  "JASPAR2020", "DirichletMultinomial", "MatrixGenerics",
  "SingleCellExperiment", "SummarizedExperiment", "S4Vectors",
  "IRanges", "DelayedArray", "Matrix"
), update = TRUE, ask = FALSE)

# ===== 第 3 步：安装 nabor（ArchR 的 GitHub 依赖）=====
cat("\n=== Step 3: GitHub 依赖 nabor ===\n")
devtools::install_github("jefferis/nabor")

# 验证 nabor
library(nabor)
cat("✅ nabor 安装成功\n")

# ===== 第 4 步：安装 ArchR 本体 =====
cat("\n=== Step 4: 安装 ArchR ===\n")
devtools::install_github("GreenleafLab/ArchR", ref = "master", 
                         repos = BiocManager::repositories())

# ===== 第 5 步：验证安装 =====
cat("\n=== Step 5: 验证 ===\n")
library(ArchR)
cat("ArchR 版本:", as.character(packageVersion("ArchR")), "\n")

# 添加基因组注释（后续分析必备）
ArchR::addArchRGenome("hg38")
cat("\n✅ ArchR 安装完成，已配置 hg38 基因组！\n")
```

#### ArchR 常见安装报错（Claude 修复）

> **👤 小白**：`devtools::install_github("GreenleafLab/ArchR")` 报错了：
> ```
> ERROR: dependency 'Cairo' is not available for package 'ArchR'
> ```

> **🤖 Claude Code**：`Cairo` 包需要系统级依赖。解决：
> ```bash
> # 先退出 R，在 bash 中安装系统依赖
> sudo apt install libcairo2-dev -y
> ```
> 然后在 R 中：
> ```r
> install.packages("Cairo")
> # 确认安装
> library(Cairo)  # 应返回 TRUE
> ```

> **👤 小白**：又报了另一个错：
> ```
> ERROR: configuration failed for package 'magick'
> ```

> **🤖 Claude Code**：`magick` 也需要系统库：
> ```bash
> sudo apt install libmagick++-dev -y
> ```

> **👤 小白**：现在装好了但 `library(ArchR)` 报：
> ```
> Error: package 'GenomicRanges' was built under R 4.4.0
> ```

> **🤖 Claude Code**：R 版本兼容问题。解决方案：
> ```r
> # 方案 1：重新编译 Bioconductor 包以匹配你的 R 版本
> BiocManager::install(version = "3.18")  # 根据你的 R 版本选择
> 
> # 方案 2：如果方案 1 不行，用 conda 管理 R 环境
> ```

#### ArchR 示范数据测试

```r
# ==========================================
# 🧬 ArchR 示范数据入门
# ==========================================
library(ArchR)

# 设置工作目录
dir.create("~/ArchR_Tutorial", showWarnings = FALSE)
setwd("~/ArchR_Tutorial")

# 创建 Arrow 文件
ArrowFiles <- createArrowFiles(
  inputFiles = c("pbmc_atac/fragments.tsv.gz"),
  sampleNames = c("PBMC"),
  minTSS = 4,
  minFrags = 1000,
  addTileMat = TRUE,
  addGeneScoreMat = TRUE
)

# 创建 ArchR 项目
proj <- ArchRProject(
  ArrowFiles = ArrowFiles,
  outputDirectory = "PBMC_ATAC",
  copyArrows = TRUE
)

# QC、降维、聚类、UMAP
proj <- filterDoublets(proj)
proj <- addIterativeLSI(proj, useMatrix = "TileMatrix", name = "IterativeLSI")
proj <- addClusters(proj, reducedDims = "IterativeLSI")
proj <- addUMAP(proj, reducedDims = "IterativeLSI")

# 可视化
plotEmbedding(proj, colorBy = "cellColData", name = "Clusters", embedding = "UMAP")
cat("\n✅ ArchR 示范数据流程跑通！\n")
```

#### 从示范数据到自测数据

> **👤 小白**：我有自己的 10x ATAC 数据（2 个样本：tumor 和 normal），怎么分析？

> **🤖 Claude Code**：只需修改输入文件路径，其余代码基本不变：
> ```r
> ArrowFiles <- createArrowFiles(
>   inputFiles = c("tumor/fragments.tsv.gz", "normal/fragments.tsv.gz"),
>   sampleNames = c("Tumor", "Normal"),
>   minTSS = 4, minFrags = 1000,
>   addTileMat = TRUE, addGeneScoreMat = TRUE
> )
> # ... 后续代码完全相同
> ```

---

### 4.3.2 scVelo — RNA 速度分析（Python）

**GitHub**: https://github.com/theislab/scvelo  
**用途**: 从 splicing 信息推断 RNA 速度，预测细胞未来状态  
**难度**: ⭐⭐⭐

```bash
# 创建环境
mamba create -n scvelo python=3.10 -y
mamba activate scvelo
mamba install -c conda-forge scanpy scvelo -y

# 验证
python -c "import scvelo as scv; print(scv.__version__)"
```

#### scVelo 示范数据 + 完整流程

```python
import scvelo as scv
import scanpy as sc

# 下载示范数据（胰腺发育，约 3000 细胞）
adata = scv.datasets.pancreas()
print(adata)

# 预处理
sc.pp.filter_genes(adata, min_shared_counts=20)
sc.pp.normalize_per_cell(adata)
sc.pp.log1p(adata)
sc.pp.highly_variable_genes(adata, n_top_genes=2000, flavor='seurat_v3')
adata = adata[:, adata.var.highly_variable].copy()

# 计算 RNA 速度
scv.pp.moments(adata, n_pcs=30, n_neighbors=30)
scv.tl.velocity(adata)
scv.tl.velocity_graph(adata)

# 可视化
scv.pl.velocity_embedding_stream(adata, basis='umap', color='clusters')

# 潜时间
scv.tl.latent_time(adata)
scv.pl.scatter(adata, color='latent_time', color_map='gnuplot')

print("✅ scVelo 示范数据流程跑通！")
```

#### 常见报错

> **👤 小白**：`scv.tl.velocity(adata)` 报错 "No spliced/unspliced counts found"

> **🤖 Claude Code**：你的数据没有 spliced/unspliced 层。需要用 velocyto 或 STARsolo 生成 loom 文件：
> ```bash
> # 方法 1：velocyto CLI（从 BAM 生成 loom）
> velocyto run10x -m repeat_mask.gtf my_sample/ path/to/genes.gtf
> 
> # 方法 2：STARsolo 直接输出
> STAR --runMode solo ... --soloFeatures Gene SJ
> ```

---

### 4.3.3 CellRank — 细胞命运概率推断

**GitHub**: https://github.com/theislab/cellrank  
**用途**: 基于 RNA velocity 推断细胞命运转变概率和初始/终末状态  
**难度**: ⭐⭐⭐

```bash
pip install cellrank
```

```python
import cellrank as cr
import scvelo as scv

# 肝脏再生示范数据
adata = cr.datasets.liver_regeneration()

# 终端状态推断
vk = cr.kernels.VelocityKernel(adata)
vk.compute_transition_matrix()
g = cr.estimators.GPCCA(vk)
g.fit(cluster_key='clusters')
g.predict_terminal_states()
g.plot_terminal_states()

# 命运概率
g.compute_fate_probabilities()
g.plot_fate_probabilities(same_plot=False)

print("✅ CellRank 示范数据流程跑通！")
```

---

### 4.3.4 CellOracle — 基因调控网络+扰动模拟

**GitHub**: https://github.com/morris-lab/CellOracle  
**用途**: 从 scRNA+scATAC 构建 GRN，模拟转录因子扰动对细胞命运的影响  
**难度**: ⭐⭐⭐⭐⭐（最复杂的组学包之一）

| 难点 | 说明 | Claude 解决方案 |
|------|------|----------------|
| Python 版本 | 要求 3.9，不兼容 3.10+ | 创建 Python 3.9 环境 |
| gimmemotifs | 大型依赖包，安装慢 | 分步安装 gimmemotifs |
| 基因组文件 | 需要下载大量参考数据 | 列出所有需要的文件及下载命令 |

```bash
mamba create -n celloracle python=3.9 -y
mamba activate celloracle
mamba install -c conda-forge -c bioconda gimmemotifs -y
pip install celloracle

python -c "import celloracle as co; print('CellOracle version:', co.__version__)"
```

---

### 4.3.5 Squidpy — 空间转录组分析（Python）

**GitHub**: https://github.com/scverse/squidpy  
**用途**: 空间转录组数据分析（10x Visium、MERFISH、Slide-seq 等）  
**难度**: ⭐⭐

```bash
mamba install -c conda-forge squidpy -y
```

```python
import squidpy as sq
import scanpy as sc

# Visium 小鼠脑数据
adata = sq.datasets.visium_hne_adata()
img = sq.datasets.visium_hne_image()

# 空间散点图
sq.pl.spatial_scatter(adata, color='cluster', size=1.5)

# 邻域富集分析
sq.gr.spatial_neighbors(adata)
sq.gr.nhood_enrichment(adata, cluster_key='cluster')
sq.pl.nhood_enrichment(adata, cluster_key='cluster')

# 配体-受体空间共表达
sq.gr.ligrec(adata, cluster_key='cluster')
sq.pl.ligrec(adata, source_groups='Pyramidal layer', target_groups='Olfactory bulb')

print("✅ Squidpy 空间转录组示范跑通！")
```

---

### 4.3.6 Giotto — 空间组学分析（R）

**GitHub**: https://github.com/drieslab/Giotto  
**用途**: R 版空间转录组分析，功能覆盖极全  
**难度**: ⭐⭐⭐⭐

```r
# 系统依赖
# sudo apt install libgdal-dev libgeos-dev libproj-dev -y

# CRAN 依赖
install.packages("remotes")
install.packages(c("Rcpp", "RcppArmadillo", "data.table", "ggplot2"))

# Bioconductor 依赖
BiocManager::install(c(
  "SingleCellExperiment", "SpatialExperiment", "DropletUtils",
  "scran", "scater", "edgeR", "limma"
))

# Giotto 本体
remotes::install_github("drieslab/Giotto@master")

# Python 环境（Giotto 需要）
library(Giotto)
installGiottoEnvironment()
checkGiottoEnvironment()
```

> **👤 小白**：`installGiottoEnvironment()` 失败了

> **🤖 Claude Code**：手动替代方案：
> ```bash
> mamba create -n giotto_env python=3.10 -y
> mamba activate giotto_env
> pip install pandas numpy python-louvain leidenalg smfishHmrf
> ```
> 然后在 R 中：`reticulate::use_condaenv("giotto_env", required = TRUE)`

---

### 4.3.7 SPOTlight — 空间去卷积

**GitHub**: https://github.com/MarcElosua/SPOTlight  
**用途**: 用 scRNA-seq 参考数据对空间转录组的每个 spot 进行细胞类型比例推断  
**难度**: ⭐⭐⭐

```r
BiocManager::install("SPOTlight")
library(SPOTlight)

# Claude 会帮你：
# 1. 下载合适的参考数据集
# 2. 下载空间转录组数据
# 3. 生成完整的去卷积代码
```

---

### 4.3.8 LIGER — 多组学整合分析

**GitHub**: https://github.com/welch-lab/liger  
**用途**: 整合多个 scRNA-seq/scATAC-seq 数据集（跨样本、跨平台、跨物种）  
**难度**: ⭐⭐⭐

```r
install.packages("rliger")
library(rliger)
```

Python 版：
```bash
pip install pyliger
```

---

### 4.3.9 scvi-tools — 深度学习单细胞分析

**GitHub**: https://github.com/scverse/scvi-tools  
**用途**: 基于深度学习的批次校正 (scVI)、数据整合 (scANVI)、差异表达  
**难度**: ⭐⭐⭐（GPU 可选，CPU 也能跑）

```bash
mamba create -n scvi python=3.10 -y
mamba activate scvi
mamba install -c conda-forge scvi-tools -y
```

```python
import scvi
import scanpy as sc

# 示范：批次校正
adata = scvi.data.purified_pbmc_dataset()
sc.pp.filter_genes(adata, min_counts=3)
adata.layers["counts"] = adata.X.copy()

scvi.model.SCVI.setup_anndata(adata, layer="counts", batch_key="batch")
model = scvi.model.SCVI(adata, n_layers=2, n_latent=30, gene_likelihood="nb")
model.train(max_epochs=100)

adata.obsm["X_scVI"] = model.get_latent_representation()
sc.pp.neighbors(adata, use_rep="X_scVI")
sc.tl.umap(adata)
sc.pl.umap(adata, color=["batch", "celltype"], ncols=2)

print("✅ scVI 批次校正完成！")
```

#### 内存优化

> **👤 小白**：scVI 训练时内存不够

> **🤖 Claude Code**：
> ```python
> # 策略 1：减少 batch size
> model.train(max_epochs=100, batch_size=64, early_stopping=True)
> # 策略 2：减少潜变量维度
> model = scvi.model.SCVI(adata, n_latent=10, n_layers=1)
> # 策略 3：对超大数据集进行子采样
> sc.pp.subsample(adata, n_obs=20000)
> ```

---

### 4.3.10 NicheNet — 配体-受体交互预测

**GitHub**: https://github.com/saeyslab/nichenetr  
**用途**: 从发送细胞预测哪些配体能激活接收细胞的哪些靶基因  
**难度**: ⭐⭐⭐

```r
remotes::install_github("saeyslab/nichenetr")
library(nichenetr)

# 下载数据库（一次性，约 1.5GB）
ligand_target_matrix <- readRDS(url("https://zenodo.org/record/7074291/files/ligand_target_matrix_nsga2r_final.rds"))
lr_network <- readRDS(url("https://zenodo.org/record/7074291/files/lr_network_human_21122021.rds"))
weighted_networks <- readRDS(url("https://zenodo.org/record/7074291/files/weighted_networks_nsga2r_final.rds"))
```

---

### 4.3.11 SCENIC+ — 增强版转录因子分析

**GitHub**: https://github.com/aertslab/SCENICplus  
**用途**: 同时利用 scRNA-seq 和 scATAC-seq 数据推断增强子驱动的 GRN  
**难度**: ⭐⭐⭐⭐⭐

```bash
mamba create -n scenicplus python=3.9 -y
mamba activate scenicplus
pip install scenicplus
# 数据库需单独下载（约 10GB+），Claude 会生成下载命令
```

> **建议**：第一次做 TF 分析，先从 pySCENIC 入门（见第一篇 1.11 节）。SCENIC+ 适合有经验的用户。

---

### 4.3.12 DeepVelo — 深度学习 RNA 速度

**GitHub**: https://github.com/bowang-lab/DeepVelo  
**用途**: 用深度神经网络比 scVelo 更准确地推断 RNA 速度  
**难度**: ⭐⭐⭐

```bash
pip install deepvelo
```

---

### 4.3.13 其他精选 GitHub 组学包速查

| 包名 | GitHub | 用途 | 难度 | 一句安装 |
|------|--------|------|:--:|------|
| **Cicero** | cole-trapnell-lab/cicero-release | scATAC 顺式调控互作 | ⭐⭐ | `BiocManager::install("cicero")` |
| **DoubletFinder** | chris-mcginnis-uoft/DoubletFinder | 双细胞检测 | ⭐ | `remotes::install_github("...")` |
| **CopyKAT** | navinlabcode/copykat | 拷贝数变异单细胞 | ⭐⭐ | `remotes::install_github("...")` |
| **inferCNV** | broadinstitute/inferCNV | 肿瘤 CNV 推断 | ⭐⭐⭐ | `remotes::install_github("...")` |
| **scArches** | theislab/scarches | 参考映射迁移学习 | ⭐⭐ | `pip install scarches` |
| **scGen** | theislab/scgen | 扰动响应预测 | ⭐⭐ | `pip install scgen` |
| **scIB** | theislab/scib | 整合方法基准测试 | ⭐⭐ | `pip install scib-metrics` |
| **muon** | scverse/muon | 多组学 Python 框架 | ⭐⭐ | `mamba install -c conda-forge muon` |
| **Vitessce** | vitessce/vitessce | 交互式可视化 | ⭐⭐⭐ | `pip install vitessce[all]` |
| **decoupler** | saezlab/decoupler | 通路活性推断 | ⭐ | `pip install decoupler` |
| **Tangram** | broadinstitute/Tangram | 空间数据映射 | ⭐⭐⭐ | `pip install tangram-sc` |
| **GSEApy** | zqfang/GSEApy | Python GSEA 富集 | ⭐ | `pip install gseapy` |
| **Pegasus** | lilab-bcb/pegasus | 大规模单细胞分析 | ⭐⭐ | `pip install pegasuspy` |

> 💡 **Claude 使用技巧**：把上表中任何一个包名发给 Claude Code，它都会生成完整的安装 + 示范数据代码。

---

## 4.4 示范数据测试全攻略

### 4.4.1 通用测试数据获取渠道

| 数据来源 | 数据类型 | Claude 辅助方式 |
|---------|---------|---------------|
| **10x Genomics Datasets** | scRNA/ATAC/Multiome/Visium | Claude 生成下载命令 |
| **SeuratData** | R 包内置示例 | Claude 指导安装和加载 |
| **Scanpy datasets** | Python 内置示例 | 一行代码 |
| **GEO** | 各种公开数据 | Claude 帮你筛选合适数据集 |
| **Zenodo/Figshare** | 论文配套数据 | Claude 生成下载命令 |
| **cellxgene** | CZ CELLxGENE 百万级数据 | Claude 指导 Census API |

### 4.4.2 每个包验证完成检查清单

> 把下面的清单发给 Claude Code：**"帮我逐项验证 XX 包是否安装成功"**

| # | 检查项 | 命令/代码 |
|---|--------|---------|
| 1 | `library(包名)` 无报错 | `library(ArchR)` |
| 2 | 版本号正常输出 | `packageVersion("ArchR")` |
| 3 | 示范数据能加载 | `data("xxx")` 或 `包名::xxx` |
| 4 | 能创建基础对象 | `proj <- ArchRProject(...)` |
| 5 | 能运行最小分析 | QC → 降维 → 可视化 |
| 6 | 能输出图片 | `plotEmbedding(...)` |

### 4.4.3 Claude 辅助调试示范数据错误

> **👤 小白**：示范数据报错了，我完全不知道哪里出了问题

> **🤖 Claude Code** 的调试策略：
> 1. **先确认环境**：`sessionInfo()`（R）或 `conda list`（Python）
> 2. **再确认数据加载**：检查数据维度、类型、是否有缺失值
> 3. **分步执行**：把长代码拆成单步，定位是哪一步出错
> 4. **对比官方文档**：确认参数名称是否有变化
> 5. **搜索 GitHub Issues**：看看是否已知 bug

---

## 4.5 从示范数据到自测数据：完整迁移指南

### 4.5.1 数据格式适配

> 这是从"跑通示范"到"分析自己数据"最关键的一步。

| 你的数据格式 | 目标工具 | Claude 帮你做什么 |
|-------------|---------|-----------------|
| 10x cellranger 输出 | Seurat/Scanpy | 生成 `Read10X()` / `sc.read_10x_mtx()` 代码 |
| h5ad (别人给的) | Seurat | 生成 `ReadH5AD()` + SeuratDisk 转换代码 |
| rds (别人给的) | Scanpy | 生成 `readRDS()` + `anndata` 转换代码 |
| 华大 FASTQ | STARsolo | 生成 STARsolo 完整参数 |
| GEO 下载的矩阵 | DESeq2 | 生成数据清洗 + 格式化代码 |
| 自己测的 FASTQ | Cell Ranger | 生成 `cellranger count` 完整参数 |

### 4.5.2 参数调优策略

> **👤 小白**：我的数据和示范数据差别很大，参数怎么调？

> **🤖 Claude Code** 的参数调优方法：
> ```
> 1. 描述你的数据：细胞数、基因数、测序深度、样本数、实验设计
> 2. Claude 根据数据规模推荐参数范围
> 3. 先用默认参数跑一遍，查看中间结果
> 4. 根据 QC 指标（如 UMAP 分群效果）调整并重跑
> 5. Claude 每一步都会解释"为什么选这个值"
> ```

### 4.5.3 结果验证与生物学解读

> **👤 小白**：跑完了，但不知道结果对不对

> **🤖 Claude Code**：
> ```r
> # Claude 会检查这些关键指标：
> # 1. QC 分布是否合理（nFeature/nCount/mito%）
> # 2. UMAP 聚类是否有生物学意义
> # 3. marker 基因是否正确
> # 4. 批次效应是否被校正
> # 5. 差异基因/峰是否与预期一致
> ```

---

## 4.6 GitHub 包安装故障全解（15 个专属错误）

### 错误 G1：`devtools::install_github` 超时

```
Error: Failed to install 'xxx' from GitHub:
 Timeout was reached: [api.github.com] Connection timed out
```

> **🤖 Claude Code**：
> ```r
> options(timeout = 600)
> # 或手动下载：
> # install.packages("包名.tar.gz", repos = NULL, type = "source")
> ```

### 错误 G2：依赖包版本不兼容

```
ERROR: dependency 'Matrix' (>= 1.7.0) is not available for 'xxx'
```

> **🤖 Claude Code**：
> ```r
> packageVersion("Matrix")  # 查看当前版本
> install.packages("Matrix")  # 更新
> # 如需旧版：install.packages("https://cran.r-project.org/src/contrib/Archive/...")
> ```

### 错误 G3：`configure: error: C compiler cannot create executables`

> **🤖 Claude Code**：
> ```bash
> which gcc  # 确认编译器存在
> sudo apt install build-essential -y  # 如缺失则安装
> ```

### 错误 G4：`fatal error: XXXX.h: No such file or directory`

> **🤖 Claude Code**：把 `XXXX.h` 告诉 Claude，它会告诉你对应的 apt 包名：
> ```bash
> # gdal.h        → sudo apt install libgdal-dev
> # curl/curl.h   → sudo apt install libcurl4-openssl-dev
> # xml2/xxx.h    → sudo apt install libxml2-dev
> # openssl/ssl.h → sudo apt install libssl-dev
> # hdf5.h        → sudo apt install libhdf5-dev
> # cairo.h       → sudo apt install libcairo2-dev
> # Magick++.h    → sudo apt install libmagick++-dev
> ```

### 错误 G5：`Error in dyn.load: unable to load shared object`

> **🤖 Claude Code**：重新从源码安装或检查缺失的动态库：
> ```bash
> ldd /path/to/package/libs/包名.so | grep "not found"
> ```

### 错误 G6：`R version mismatch (R >= 4.4 required)`

> **🤖 Claude Code**：
> ```bash
> # 用 conda 管理不同 R 版本（推荐）
> mamba create -n r44 -c conda-forge r-base=4.4 r-essentials -y
> ```

### 错误 G7：`git clone` 失败

```
Error in git2r::clone(...) : failed to resolve address for github.com
```

> **🤖 Claude Code**：
> ```r
> Sys.setenv(DOWNLOAD_METHOD = "curl")
> # 或手动下载 ZIP：
> # install.packages("pkg-master.zip", repos = NULL, type = "source")
> # 国内加速：
> # install.packages("https://ghproxy.com/https://github.com/user/pkg/archive/master.tar.gz")
> ```

### 错误 G8：`no package called 'XXX'` — 间接依赖缺失

> **🤖 Claude Code**：找到缺失的包名后：
> ```r
> BiocManager::install("缺失的包名")
> ```

### 错误 G9：Python `ModuleNotFoundError: No module named 'XXX'`

> **🤖 Claude Code**：
> ```bash
> which python && which pip  # 确认使用正确的环境
> python -m pip install 包名  # 确保用正确的 pip
> ```

### 错误 G10：`memory exhausted` — 编译时内存不足

> **🤖 Claude Code**：
> ```bash
> export MAKEFLAGS="-j2"  # 限制并行编译线程数
> # 或增加 swap
> sudo fallocate -l 10G /swapfile && sudo mkswap /swapfile && sudo swapon /swapfile
> ```

### 错误 G11：`package 'XXX' is in use and will not be installed`

> **🤖 Claude Code**：退出所有 R session，新 session 中：
> ```r
> remove.packages("XXX")
> ```

### 错误 G12：macOS `clang: error: unsupported option '-fopenmp'`

> **🤖 Claude Code**：
> ```bash
> brew install llvm libomp
> # 在 ~/.R/Makevars 中添加 CC/CXX/LDFLAGS 配置
> ```

### 错误 G13：`ERROR: This package requires gfortran`

> **🤖 Claude Code**：
> ```bash
> sudo apt install gfortran -y  # Linux
> brew install gfortran         # macOS
> ```

### 错误 G14：`make: cmake: Command not found`

> **🤖 Claude Code**：
> ```bash
> sudo apt install cmake -y
> ```

### 错误 G15：GitHub 仓库不存在或已改名

```
Error: HTTP error 404. Not Found
```

> **🤖 Claude Code**：
> 1. 检查 GitHub 仓库 URL 是否正确
> 2. 搜索该包是否已迁移到别的仓库
> 3. 检查是否有 Bioconductor 版本
> 4. 如果包已废弃，Claude 会推荐替代方案

> 💡 **一句总结**：**GitHub 组学包安装的本质 = 系统依赖 + R/Python 依赖 + 版本兼容 + 网络优化。而 Claude Code 可以一次性帮你理清全部四个维度。**

---

## 4.7 自测数据应用工作流

### 从零到结果的完整路径

```
┌─────────────┐    ┌──────────────┐    ┌────────────────┐    ┌──────────┐
│  自己的数据   │ →  │  Claude 分析  │ →  │  适配示范代码   │ →  │  结果解读 │
│ (FASTQ/h5ad) │    │  数据特征     │    │  修改参数运行   │    │  生物学结论 │
└─────────────┘    └──────────────┘    └────────────────┘    └──────────┘
```

### 实战案例：用 Claude 从华大 FASTQ 到 Seurat 对象

> **👤 小白**：我的数据是 DNBelab C4 测序的 FASTQ，想用 Seurat 分析，请生成完整代码

> Claude 会根据：
> - 你的 FASTQ 命名 → 正确的 `--soloCBwhitelist` 参数
> - 你的物种 → 正确的参考基因组
> - 你的样本数 → 批量处理脚本

**这一切只需要你告诉 Claude 三件事**：
1. 我的 FASTQ 文件在哪里？
2. 是什么平台测的（10x / 华大 / Smart-seq2）？
3. 想分析什么（聚类 / 差异 / 拟时序 / 细胞通讯）？

---

# 附录

## 附录 A：Claude Code 对话技巧速查

### ✅ 高效提问模板

| 场景 | 模板 |
|------|------|
| 安装工具 | "帮我在 [系统] 上安装 [工具名]，列出所有步骤" |
| 跑流程 | "我有一个 [数据类型]，想用 [工具] 做 [分析目标]，给我完整的代码" |
| 报错 | "运行 [命令/代码] 时报了以下错误：[粘贴完整报错]，怎么解决？" |
| 对比 | "[工具A] 和 [工具B] 做 [任务] 有什么区别？我的场景是 [描述]" |
| 参数 | "[工具] 的 [参数名] 应该怎么设置？我的数据是 [描述数据]" |
| 解读 | "我的分析结果显示 [描述]，这代表什么生物学意义？" |

### ❌ 低效提问 vs ✅ 高效提问

| ❌ 低效 | ✅ 高效 |
|--------|--------|
| "Seurat 报错了怎么办" | "Seurat v5 中 RunUMAP 报错 'Cannot find umap-learn'，我的系统是 Ubuntu 22.04" |
| "怎么分析单细胞数据" | "我有 10x Genomics PBMC 数据（3 个样本，每个约 5000 细胞），想做免疫细胞亚群注释" |
| "安装失败" | "在 R 4.3 上用 BiocManager 装 DESeq2 时报错 'non-zero exit status'，完整报错如下：[粘贴]" |

### 💡 进阶技巧

1. **粘贴完整报错信息**：报错的前后几行都很重要，不要只复制最后一行。
2. **提供环境信息**：操作系统、R/Python 版本、包版本 → 用 `sessionInfo()` 或 `conda list` 获取。
3. **分步确认**：大任务拆成小步骤，每步完成后让 Claude 确认结果。
4. **用 CLAUDE.md 记住偏好**：在 `~/.claude/CLAUDE.md` 中写明你的分析偏好。

---

## 附录 B：组学项目标准目录结构

> 把下面的模板发给 Claude：**"帮我在当前目录创建这个项目结构"**

```
my_scRNA_project/
├── README.md                    # 项目说明
├── CLAUDE.md                    # Claude Code 记忆文件（项目级偏好）
├── environment.yml              # conda 环境文件
│
├── data/
│   ├── raw/                     # 原始 FASTQ 文件（只读）
│   ├── reference/               # 参考基因组和注释文件
│   └── processed/               # 处理后的中间文件
│
├── results/
│   ├── qc/                      # QC 结果
│   ├── clustering/              # 聚类结果
│   ├── deg/                     # 差异表达
│   ├── enrichment/              # 富集分析
│   ├── trajectory/              # 拟时序分析
│   └── figures/                 # 最终图表
│
├── scripts/
│   ├── 01_qc.R                  # 按编号排序，一目了然
│   ├── 02_clustering.R
│   ├── 03_annotation.R
│   ├── 04_deg.R
│   └── 05_visualization.R
│
└── reports/
    ├── analysis_report.Rmd      # RMarkdown 分析报告
    └── figures/                 # 报告用图
```

---

## 附录 C：12 周从零到实战学习路线

> 🗓️ 每天 2-3 小时，搭配 Claude Code 全程辅助

| 周 | 主题 | 具体任务 | Claude Code 辅助方式 |
|:--:|------|---------|-------------------|
| **1** | 🐧 Linux + 环境 | 学习基本命令、安装 conda/R/Python | 命令解释 + 环境安装指导 |
| **2** | 📊 R/Python 基础 | 数据处理、绑图基础 | 代码生成 + 错误修复 |
| **3** | 🧬 单细胞概念 | 理解文库构建、读序结构、基因表达矩阵 | 概念解释 + 图文说明 |
| **4** | 🔧 比对和定量 | 安装 Cell Ranger/STARsolo，跑 pbmc1k 测试 | 命令生成 + 参数解释 |
| **5** | 📦 Seurat 入门 | pbmc3k 标准流程（QC → 聚类 → 注释） | 全流程代码 + 结果解读 |
| **6** | 📦 Scanpy 入门 | 同样数据用 Python 再跑一遍 | 代码对比 + 双语言理解 |
| **7** | 🔬 差异表达 | 找 marker 基因、GO/KEGG 富集分析 | 代码 + 结果生物学解释 |
| **8** | 🛤️ 拟时序分析 | Monocle3 / CytoTRACE | 安装 + 完整代码 |
| **9** | 💬 细胞通讯 | CellChat 分析 + 可视化 | 完整流程 + 图解读 |
| **10** | 🧠 高级话题 | RNA velocity、TF regulon、批次校正 | 根据兴趣选题，Claude 定制教程 |
| **11** | 📝 实战项目 | 用真实数据（或 GEO 公开数据）独立分析 | 全过程陪伴式编程 |
| **12** | 📄 报告撰写 | RMarkdown 分析报告 + 图表优化 | 代码生成 + 写作润色 |

---

## 🎯 最终总结

> **Claude Code 是组学小白的"24 小时私人导师"**：
>
> - 🛠️ **装不上工具？** → 告诉 Claude 你的系统，它给你精确的命令
> - 📖 **不知道怎么跑？** → 告诉 Claude 你的数据，它给你完整代码
> - 🐛 **报错看不懂？** → 粘贴给 Claude，它秒级诊断 + 修复
> - 🧠 **结果不会解读？** → 描述你的发现，Claude 帮你解读生物学意义
>
> **你只需要掌握一件事：如何清楚地向 Claude Code 描述你的问题。**

---

> 🔗 **GitHub Repository**: [ZhaoLabs-SJTU/Claude-test](https://github.com/ZhaoLabs-SJTU/Claude-test)
> 📅 **最后更新**: 2025-07
> 🧬 **Made for 组学零基础小白 | Powered by Claude Code**
