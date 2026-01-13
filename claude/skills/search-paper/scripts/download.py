#!/usr/bin/env python3
"""Download PDF from paper URL"""

import sys
import os
import re
import subprocess

def download_arxiv(url: str, save_dir: str) -> str:
    """Download from arXiv"""
    arxiv_id_match = re.search(r'(\d{4}\.\d{4,5})', url)
    if not arxiv_id_match:
        return "Error: 无法提取 arXiv ID"

    arxiv_id = arxiv_id_match.group(1)
    pdf_url = f"https://arxiv.org/pdf/{arxiv_id}.pdf"
    filename = f"arxiv_{arxiv_id}.pdf"
    save_path = os.path.join(save_dir, filename)

    result = subprocess.run(
        ["curl", "-L", "-o", save_path, pdf_url],
        capture_output=True,
        timeout=120
    )

    if os.path.exists(save_path) and os.path.getsize(save_path) > 1000:
        return save_path
    return "Error: 下载失败"


def download_ieee(url: str, save_dir: str) -> str:
    """Download from IEEE using patchright"""
    doc_id_match = re.search(r'document/(\d+)', url)
    if not doc_id_match:
        return "Error: 无法提取 IEEE 文档 ID"

    doc_id = doc_id_match.group(1)
    filename = f"ieee_{doc_id}.pdf"
    save_path = os.path.join(save_dir, filename)

    from patchright.sync_api import sync_playwright

    with sync_playwright() as p:
        context = p.chromium.launch_persistent_context(
            user_data_dir="/tmp/patchright_profile",
            headless=False,
            no_viewport=True,
            args=["--disable-blink-features=AutomationControlled"]
        )
        page = context.pages[0] if context.pages else context.new_page()

        pdf_url = f"https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber={doc_id}"
        page.goto(pdf_url, wait_until="networkidle", timeout=90000)
        page.wait_for_timeout(8000)

        # Find PDF frame
        for frame in page.frames:
            if "ielx" in frame.url or "getPDF" in frame.url:
                response = page.request.get(frame.url)
                if response.ok:
                    with open(save_path, "wb") as f:
                        f.write(response.body())
                    context.close()
                    return save_path

        context.close()
    return "Error: 下载失败"


def main():
    import argparse
    parser = argparse.ArgumentParser(description="Download paper PDF")
    parser.add_argument("url", help="Paper URL")
    parser.add_argument("-o", "--output", default="~/papers", help="Output directory")
    args = parser.parse_args()

    save_dir = os.path.expanduser(args.output)
    os.makedirs(save_dir, exist_ok=True)

    url = args.url.lower()

    if "arxiv" in url:
        result = download_arxiv(args.url, save_dir)
    elif "ieee" in url:
        result = download_ieee(args.url, save_dir)
    elif "sciencedirect" in url or "elsevier" in url:
        result = "Elsevier PDF 需要手动下载（Cloudflare 保护）"
    else:
        result = f"不支持的来源: {args.url}"

    print(result)


if __name__ == "__main__":
    main()
