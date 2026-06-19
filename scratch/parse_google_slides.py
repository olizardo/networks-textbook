import json
import re

def main():
    file_path = r"C:\Users\Omar Lizardo\.gemini\antigravity-cli\brain\a2b29b6d-ecff-4979-ab77-b7d6b26934e7\.system_generated\steps\91\content.md"
    
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()
        
    print(f"Read content length: {len(content)}")
    
    # Google slides sometimes embedded in a JavaScript structure like requests: [...] or initialData or similar
    # Let's search for text strings that might represent slide contents.
    # Often slide content is stored in JSON structures or CDATA blocks.
    # Let's find all occurrences of strings in quotes or similar.
    # Or find words and see where they cluster.
    
    # Let's search for "Tradeoff", "Bandwidth", "Diversity" and print their surrounding contexts
    keywords = ["tradeoff", "bandwidth", "diversity", "aral", "alstyne"]
    
    # We will search for matches and print 100 characters before and after
    print("\n--- Keyword Contexts ---")
    for kw in keywords:
        print(f"\nKeyword: {kw}")
        for m in re.finditer(re.escape(kw), content, re.IGNORECASE):
            start = max(0, m.start() - 150)
            end = min(len(content), m.end() + 150)
            snippet = content[start:end].replace('\n', ' ')
            print(f"  ... {snippet} ...")

if __name__ == "__main__":
    main()
