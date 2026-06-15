import urllib.request
import sys

url = "https://docs.google.com/presentation/d/1DUQnYBZfcLOiK-_2KD8RjWRDFbKIofJfetcbS5fsPz0/export/pdf"
try:
    print("Fetching URL...")
    urllib.request.urlretrieve(url, "slides_temp.pdf")
    print("Success! PDF downloaded as slides_temp.pdf")
except Exception as e:
    print(f"Error fetching PDF: {e}", file=sys.stderr)
