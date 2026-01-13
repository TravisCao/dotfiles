---
name: search-paper
description: 学术论文搜索、摘要查看、PDF下载、BibTeX抓取。支持 Google Scholar、arXiv、IEEE、Elsevier。
---

<!--
Trigger keywords: 搜论文, search paper, 找论文, 下载论文, 学术搜索, Google Scholar, arXiv, IEEE, 文献调研
-->

# Search Paper Skill

学术论文搜索与下载工具。通过 Google Scholar 搜索，支持从 arXiv、IEEE、Elsevier 获取论文信息和下载 PDF。

## 平台支持

| 平台 | 搜索 | 摘要 | PDF 下载 | BibTeX |
|------|------|------|----------|--------|
| arXiv | ✅ | ✅ | ✅ | ✅ |
| IEEE Xplore | ✅ | ✅ | ✅ | ✅ |
| Elsevier | ✅ | ✅ | ❌ Cloudflare | ✅ |

## 命令格式

所有命令需要 `xvfb-run` 前缀（服务器无显示器环境）：

```bash
SKILL_DIR=~/.claude/skills/search-paper/scripts

# 搜索论文
xvfb-run -a uvx --from patchright --with patchright python $SKILL_DIR/search.py "关键词"

# 下载 PDF (后台运行)
xvfb-run -a uvx --from patchright --with patchright python $SKILL_DIR/download.py "论文URL"

# 获取 BibTeX
xvfb-run -a uvx --from patchright --with patchright,requests python $SKILL_DIR/bibtex.py "URL或DOI"
```

## 脚本详解

### 1. search.py - 搜索论文

**用法**:
```bash
xvfb-run -a uvx --from patchright --with patchright python $SKILL_DIR/search.py "query" [-n 数量] [--json]
```

**参数**:
- `query`: 搜索关键词
- `-n, --limit`: 返回数量，默认 10
- `--json`: JSON 格式输出

**返回字段**:
| 字段 | 说明 |
|------|------|
| `title` | 论文标题 |
| `info` | 作者、期刊、年份 |
| `citations` | 被引次数 |
| `source` | 来源: ieee / arxiv / elsevier / other |
| `url` | 论文链接 |
| `snippet` | 摘要片段 |

### 2. download.py - 下载 PDF

**用法**:
```bash
xvfb-run -a uvx --from patchright --with patchright python $SKILL_DIR/download.py "URL" [-o 目录]
```

**参数**:
- `URL`: 论文页面 URL
- `-o, --output`: 保存目录，默认 `~/papers`

**支持来源**:
- ✅ arXiv - 直接下载
- ✅ IEEE - patchright 绕过检测
- ❌ Elsevier - Cloudflare 保护，需手动

**输出**: 下载成功返回文件路径，失败返回错误信息

> ⚠️ **耗时 30-60 秒**，建议后台运行

### 3. bibtex.py - 获取引用

**用法**:
```bash
xvfb-run -a uvx --from patchright --with patchright,requests python $SKILL_DIR/bibtex.py "URL或DOI"
```

**支持输入**:
- arXiv URL: `https://arxiv.org/abs/2301.00001`
- IEEE URL: `https://ieeexplore.ieee.org/document/12345`
- DOI: `10.1109/TPWRS.2023.1234567`

**输出**: BibTeX 格式引用

## Agent 使用指南

### 典型工作流

```
用户: 帮我搜一下 quantum computing optimization 的论文

Agent:
1. 运行 search.py "quantum computing optimization"
2. 解析返回的论文列表
3. 按被引量/年份分析，总结研究趋势
4. 展示格式化的论文列表给用户

用户: 第 2 篇看起来不错，下载一下

Agent:
1. 从搜索结果提取第 2 篇的 URL
2. 后台运行 download.py "URL"
3. 等待完成，返回文件路径

用户: 给我这篇的 BibTeX

Agent:
1. 运行 bibtex.py "URL"
2. 返回 BibTeX 内容
```

### 结果展示格式

搜索结果建议按表格展示：

```markdown
| # | 论文 | 作者 | 期刊 | 年份 | 被引 | 来源 |
|---|------|------|------|------|------|------|
| 1 | Title... | Author et al. | IEEE TSG | 2024 | 42 | ieee |
```

## 技术说明

### 为什么需要 patchright + xvfb？

- **patchright**: Playwright 的反检测分支，绕过 Google Scholar/IEEE/Elsevier 的 bot 检测
- **xvfb**: 虚拟显示器，在无 GUI 服务器上运行 headed 浏览器
- **uvx**: uv 工具的执行器，自动管理 Python 依赖，无需手动安装

### 系统依赖

```bash
# 必需
sudo apt-get install xvfb

# uvx 自动安装的 Python 包
# - patchright
# - requests
```

### 首次运行

patchright 首次运行会自动下载 Chromium（约 150MB）。

## 目录结构

```
search-paper/
├── SKILL.md        # 本文件
└── scripts/
    ├── search.py   # 搜索脚本
    ├── download.py # 下载脚本
    └── bibtex.py   # BibTeX 脚本
```

## 注意事项

1. **请求频率**: Google Scholar 有反爬机制，避免短时间内多次搜索
2. **网络环境**: 需在有机构访问权限的网络（如学校网络）下使用，才能下载付费论文
3. **Elsevier 限制**: 只能获取摘要和 BibTeX，PDF 需手动下载
4. **超时处理**: 如果搜索/下载超时，可能是网络问题或被临时限制，稍后重试
