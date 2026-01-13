#!/usr/bin/env python3
"""Get BibTeX citation from paper URL or DOI"""

import sys
import re
import requests


def get_bibtex_from_doi(doi: str) -> str:
    """Get BibTeX from DOI using CrossRef"""
    if "doi.org/" in doi:
        doi = doi.split("doi.org/")[-1]

    try:
        response = requests.get(
            f"https://doi.org/{doi}",
            headers={"Accept": "application/x-bibtex"},
            timeout=30
        )
        if response.ok:
            return response.text
        return f"Error: DOI 查询失败 ({response.status_code})"
    except Exception as e:
        return f"Error: {e}"


def get_bibtex_arxiv(url: str) -> str:
    """Get BibTeX from arXiv"""
    arxiv_id_match = re.search(r'(\d{4}\.\d{4,5})', url)
    if not arxiv_id_match:
        return "Error: 无法提取 arXiv ID"

    arxiv_id = arxiv_id_match.group(1)
    try:
        response = requests.get(f"https://arxiv.org/bibtex/{arxiv_id}", timeout=30)
        if response.ok:
            return response.text
        return f"Error: arXiv BibTeX 获取失败 ({response.status_code})"
    except Exception as e:
        return f"Error: {e}"


def get_bibtex_ieee(url: str) -> str:
    """Get BibTeX from IEEE"""
    doc_id_match = re.search(r'document/(\d+)', url)
    if not doc_id_match:
        return "Error: 无法提取 IEEE 文档 ID"

    doc_id = doc_id_match.group(1)

    from patchright.sync_api import sync_playwright

    with sync_playwright() as p:
        context = p.chromium.launch_persistent_context(
            user_data_dir="/tmp/patchright_profile",
            headless=False,
            no_viewport=True,
            args=["--disable-blink-features=AutomationControlled"]
        )
        page = context.pages[0] if context.pages else context.new_page()

        # Visit paper page first
        page.goto(f"https://ieeexplore.ieee.org/document/{doc_id}",
                  wait_until="domcontentloaded", timeout=60000)
        page.wait_for_timeout(3000)

        # Get BibTeX from API
        bibtex_url = f"https://ieeexplore.ieee.org/rest/search/citation/format?recordIds={doc_id}&fromPage=&citations-format=citation-only&download-format=download-bibtex"
        response = page.request.get(bibtex_url)

        context.close()

        if response.ok:
            return response.text()
        return "Error: IEEE BibTeX 获取失败"


def main():
    import argparse
    parser = argparse.ArgumentParser(description="Get BibTeX citation")
    parser.add_argument("input", help="Paper URL or DOI")
    args = parser.parse_args()

    inp = args.input

    # Check if DOI
    if inp.startswith("10.") or "doi.org" in inp:
        result = get_bibtex_from_doi(inp)
    elif "arxiv" in inp.lower():
        result = get_bibtex_arxiv(inp)
    elif "ieee" in inp.lower():
        result = get_bibtex_ieee(inp)
    else:
        result = "请提供 arXiv/IEEE URL 或 DOI"

    print(result)


if __name__ == "__main__":
    main()
