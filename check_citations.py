import os
import re

# Read valid citations from bib file
valid_citations = set()
with open('networks.bib', 'r', encoding='utf-8') as f:
    for line in f:
        match = re.match(r'^@[a-zA-Z]+\{([^,]+),', line)
        if match:
            valid_citations.add(match.group(1))

qmd_files = [f for f in os.listdir('.') if f.endswith('.qmd')]
found_citations = set()
citation_re = re.compile(r'(@[a-zA-Z0-9_.-]+)')

missing = []

for f in qmd_files:
    try:
        with open(f, 'r', encoding='utf-8') as file:
            content = file.read()
            # Find all citations (usually starts with @ but not a crossref prefix)
            # A bit simplistic, let's just find anything matching @... inside brackets or standalone
            # Actually, standard is [@key] or @key.
            matches = re.finditer(r'\[.*?@([a-zA-Z0-9_.-]+).*?\]', content)
            for m in matches:
                key = m.group(1)
                # Ignore crossrefs
                if not any(key.startswith(prefix + '-') for prefix in ['fig', 'tbl', 'sec', 'eq', 'thm']):
                    if key not in valid_citations:
                        missing.append((key, f))
            
            # Also find standalone like @key
            matches = re.finditer(r'(?<!\w)@([a-zA-Z0-9_.-]+)', content)
            for m in matches:
                key = m.group(1)
                if not any(key.startswith(prefix + '-') for prefix in ['fig', 'tbl', 'sec', 'eq', 'thm']):
                    if key not in valid_citations:
                        # might be email or something else, but let's collect
                        missing.append((key, f))
    except Exception as e:
        pass

missing = list(set(missing)) # unique
for key, file in sorted(missing, key=lambda x: (x[1], x[0])):
    print(f"{file}: {key}")

