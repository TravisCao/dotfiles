#!/usr/bin/env python3
"""Search Google Scholar for papers"""

import sys
import os

# Add lib to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'lib'))

def search_scholar_patchright(query: str, limit: int = 10):
    """Search Google Scholar using patchright (bypasses Cloudflare)"""
    from patchright.sync_api import sync_playwright

    with sync_playwright() as p:
        context = p.chromium.launch_persistent_context(
            user_data_dir="/tmp/patchright_scholar",
            headless=False,
            no_viewport=True,
            args=["--disable-blink-features=AutomationControlled"]
        )
        page = context.pages[0] if context.pages else context.new_page()

        search_url = f"https://scholar.google.com/scholar?q={query.replace(' ', '+')}"
        page.goto(search_url, wait_until="domcontentloaded", timeout=60000)
        page.wait_for_timeout(5000)

        results = []
        items = page.locator(".gs_ri").all()

        for i, item in enumerate(items[:limit]):
            try:
                paper = {"index": i + 1}

                # Title and link
                title_elem = item.locator("h3 a").first
                paper["title"] = title_elem.inner_text(timeout=2000)
                paper["url"] = title_elem.get_attribute("href")

                # Detect source
                url = paper["url"].lower()
                if "ieee" in url:
                    paper["source"] = "ieee"
                elif "arxiv" in url:
                    paper["source"] = "arxiv"
                elif "sciencedirect" in url or "elsevier" in url:
                    paper["source"] = "elsevier"
                else:
                    paper["source"] = "other"

                # Author/venue info
                try:
                    paper["info"] = item.locator(".gs_a").inner_text(timeout=2000)
                except:
                    paper["info"] = ""

                # Snippet
                try:
                    paper["snippet"] = item.locator(".gs_rs").inner_text(timeout=2000)
                except:
                    paper["snippet"] = ""

                # Citations
                try:
                    cite_text = item.locator("a:has-text('Cited by')").inner_text(timeout=2000)
                    paper["citations"] = cite_text.replace("Cited by ", "")
                except:
                    paper["citations"] = "0"

                results.append(paper)
            except Exception as e:
                continue

        context.close()
        return results


def main():
    import argparse
    parser = argparse.ArgumentParser(description="Search Google Scholar")
    parser.add_argument("query", help="Search query")
    parser.add_argument("-n", "--limit", type=int, default=10, help="Number of results")
    parser.add_argument("--json", action="store_true", help="Output as JSON")
    args = parser.parse_args()

    results = search_scholar_patchright(args.query, args.limit)

    if args.json:
        import json
        print(json.dumps(results, ensure_ascii=False, indent=2))
    else:
        print(f"\n搜索结果: \"{args.query}\"\n")
        print("-" * 80)
        for paper in results:
            print(f"\n{paper['index']}. {paper['title']}")
            print(f"   {paper['info']}")
            print(f"   被引: {paper['citations']} | 来源: {paper['source']}")
            if paper['snippet']:
                print(f"   {paper['snippet'][:120]}...")
            print(f"   链接: {paper['url']}")


if __name__ == "__main__":
    main()
