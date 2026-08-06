import os
import re

qmd_files = [f for f in os.listdir('.') if f.endswith('.qmd')]

defined = set()
references = set()

# Stop matching at whitespace or bracket
inline_label_re = re.compile(r'\{#(fig|tbl|sec|eq|thm|lem|cor|prp|cnj|def|exm|rem)-([^}\s]+)')
chunk_label_re = re.compile(r'#\|\s*label:\s*"?((?:fig|tbl|sec|eq|thm|lem|cor|prp|cnj|def|exm|rem)-[^"\s]+)"?')
ref_re = re.compile(r'@(fig|tbl|sec|eq|thm|lem|cor|prp|cnj|def|exm|rem)-([a-zA-Z0-9_-]+)')

for f in qmd_files:
    try:
        with open(f, 'r', encoding='utf-8') as file:
            content = file.read()
            
            for match in inline_label_re.finditer(content):
                defined.add(f"{match.group(1)}-{match.group(2)}")
                
            for match in chunk_label_re.finditer(content):
                defined.add(match.group(1))
                
            for match in ref_re.finditer(content):
                ref = f"{match.group(1)}-{match.group(2)}"
                references.add((ref, f))
    except Exception as e:
        pass

missing = []
for ref, file in references:
    if ref in defined:
        continue
    # Check for subfigure/subtable suffix
    if re.search(r'-\d+$', ref):
        base_ref = ref.rsplit('-', 1)[0]
        if base_ref in defined:
            continue
    missing.append((ref, file))

if missing:
    print("Potentially broken references found:")
    for ref, file in sorted(missing, key=lambda x: (x[1], x[0])):
        print(f"{file}: @{ref}")
else:
    print("No broken references found.")
