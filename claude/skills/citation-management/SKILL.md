---
name: citation-management
description: DOI转BibTeX、文献搜索、元数据提取、引用验证。用于论文引用管理。
---

# Citation Management

## 工具列表

| 脚本 | 功能 |
|------|------|
| `doi_to_bibtex.py` | DOI 转 BibTeX |
| `search_google_scholar.py` | Google Scholar 搜索 |
| `extract_metadata.py` | 从 DOI/PMID/arXiv/URL 提取元数据 |
| `validate_citations.py` | 验证 BibTeX 文件 |

## 用法

### DOI 转 BibTeX

```bash
# 单个DOI
python scripts/doi_to_bibtex.py 10.1109/TPWRS.2023.1234567

# 批量（从文件读取）
python scripts/doi_to_bibtex.py -i dois.txt -o references.bib

# 输出JSON格式
python scripts/doi_to_bibtex.py 10.1109/xxx --format json
```

### Google Scholar 搜索

```bash
# 基础搜索
python scripts/search_google_scholar.py "smart grid optimization" --limit 20

# 按年份过滤
python scripts/search_google_scholar.py "deep reinforcement learning" \
  --year-start 2020 --year-end 2024 --limit 50

# 使用代理（降低被封风险）
python scripts/search_google_scholar.py "query" --use-proxy
```

**注意**：Google Scholar 有反爬机制，建议：
- 每次请求间隔 10-30 秒
- 单次不要查太多（<50篇）
- 被封了换IP或等一段时间

### 提取元数据

```bash
# 从DOI提取
python scripts/extract_metadata.py 10.1109/TPWRS.2023.1234567

# 从arXiv ID提取
python scripts/extract_metadata.py 2301.00001

# 从URL提取
python scripts/extract_metadata.py "https://arxiv.org/abs/2301.00001"

# 批量提取
python scripts/extract_metadata.py -i identifiers.txt -o metadata.json
```

### 验证引用

```bash
# 验证BibTeX文件
python scripts/validate_citations.py references.bib

# 输出JSON格式的验证报告
python scripts/validate_citations.py references.bib --format json -o report.json
```

检查内容：
- 必填字段是否完整（author, title, year等）
- 推荐字段是否存在（volume, pages, doi等）
- 格式是否正确

## 依赖

```bash
pip install requests scholarly
```
