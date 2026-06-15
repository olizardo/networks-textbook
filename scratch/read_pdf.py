import sys

def try_extract():
    try:
        import pypdf
        print("Using pypdf")
        reader = pypdf.PdfReader("slides_temp.pdf")
        with open("scratch/extracted_slides.txt", "w", encoding="utf-8") as f:
            for i, page in enumerate(reader.pages):
                f.write(f"--- Slide {i+1} ---\n")
                text = page.extract_text()
                if text:
                    f.write(text)
                f.write("\n\n")
        print("Successfully wrote scratch/extracted_slides.txt")
        return True
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        return False

if __name__ == "__main__":
    try_extract()
