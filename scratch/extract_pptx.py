import os
import zipfile
import xml.etree.ElementTree as ET

def extract_text_from_pptx(pptx_path):
    text_runs = []
    try:
        with zipfile.ZipFile(pptx_path, 'r') as zip_ref:
            # List all files in zip
            namelist = zip_ref.namelist()
            # Slides are usually under ppt/slides/slideN.xml
            slide_files = sorted(
                [f for f in namelist if f.startswith('ppt/slides/slide') and f.endswith('.xml')],
                key=lambda x: int(''.join(filter(str.isdigit, x))) if any(c.isdigit() for c in x) else 0
            )
            
            for slide_file in slide_files:
                slide_xml = zip_ref.read(slide_file)
                root = ET.fromstring(slide_xml)
                
                # The text elements in openxml are represented by <a:t> (text) tags inside <a:r> (run)
                # Let's search recursively for all text elements.
                slide_text = []
                for elem in root.iter():
                    if elem.tag.endswith('}t') and elem.text:
                        slide_text.append(elem.text)
                
                if slide_text:
                    text_runs.append((slide_file, " ".join(slide_text)))
    except Exception as e:
        print(f"Error reading {pptx_path}: {e}")
    return text_runs

def main():
    import sys
    # Reconfigure stdout to use UTF-8 if possible
    try:
        sys.stdout.reconfigure(encoding='utf-8')
    except AttributeError:
        pass
        
    ppt_dir = r"C:\Users\Omar Lizardo\Google Drive\UCLA\networks-textbook\ppt_slides"
    keywords = ["burt", "structural hole", "constraint", "broker", "brokerage", "bandwidth"]
    output_path = r"C:\Users\Omar Lizardo\Google Drive\UCLA\networks-textbook\scratch\extracted_slides_sht.txt"
    
    with open(output_path, "w", encoding="utf-8") as out:
        for root_dir, dirs, files in os.walk(ppt_dir):
            for file in files:
                if file.lower().endswith('.pptx'):
                    pptx_path = os.path.join(root_dir, file)
                    out.write(f"\n========================================\nFILE: {file}\nPATH: {pptx_path}\n========================================\n")
                    text_runs = extract_text_from_pptx(pptx_path)
                    
                    found_any = False
                    for slide_file, text in text_runs:
                        lower_text = text.lower()
                        if any(kw in lower_text for kw in keywords):
                            found_any = True
                            out.write(f"  [{os.path.basename(slide_file)}]: {text}\n\n")
                    
                    if not found_any:
                        out.write("  No keywords found in this presentation.\n")
    print(f"Extraction completed. Results written to {output_path}")

if __name__ == "__main__":
    main()
