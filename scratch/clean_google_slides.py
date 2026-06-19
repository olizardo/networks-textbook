import re
import json

def main():
    file_path = r"C:\Users\Omar Lizardo\.gemini\antigravity-cli\brain\a2b29b6d-ecff-4979-ab77-b7d6b26934e7\.system_generated\steps\91\content.md"
    
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()
        
    # Let's search for the JSON strings. The slides content is stored as JSON array.
    # Let's find all occurrences of strings like: [15, "...", null, 0, "something"]
    # Or more generally, we can look for strings containing the text.
    # Actually, we can search for the text array elements.
    # Let's extract all list elements of the form [15, ..., "string"] or [3, ..., "string"] 
    # and print any text containing alphanumeric characters.
    
    # Alternatively, let's find all chunks of text in quotes that look like slide content.
    # In Google Slides, the text is inside strings. Let's find all double-quoted strings.
    matches = re.findall(r'"([^"\\]*(?:\\.[^"\\]*)*)"', content)
    
    # Clean matches: filter out long strings that look like JS code, and short ones.
    slide_texts = []
    seen = set()
    for m in matches:
        # Unescape unicode
        try:
            m_clean = m.encode().decode('unicode-escape')
        except:
            m_clean = m
        m_clean = m_clean.strip()
        if len(m_clean) > 15 and not m_clean.startswith('http') and not m_clean.startswith('docs') and not m_clean.startswith('gb_') and not m_clean.startswith('kix.'):
            # check if it's mostly english text
            if re.search(r'[a-zA-Z]{3,}', m_clean):
                if m_clean not in seen:
                    seen.add(m_clean)
                    slide_texts.append(m_clean)
                    
    # Let's output these to a clean file
    out_path = r"C:\Users\Omar Lizardo\Google Drive\UCLA\networks-textbook\scratch\google_slides_clean.txt"
    with open(out_path, "w", encoding="utf-8") as out:
        out.write("EXTRACTED TEXT FROM GOOGLE SLIDES:\n\n")
        for idx, text in enumerate(slide_texts):
            out.write(f"[{idx+1}]: {text}\n\n")
            
    print(f"Extracted {len(slide_texts)} unique text blocks. Written to {out_path}")

if __name__ == "__main__":
    main()
