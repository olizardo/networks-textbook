import os
import re
import sys

def get_active_chapters():
    chapters = []
    if not os.path.exists('_quarto.yml'):
        print("Warning: _quarto.yml not found. Checking all .qmd files.")
        return [f for f in os.listdir('.') if f.endswith('.qmd')]
        
    with open('_quarto.yml', 'r', encoding='utf-8') as f:
        content = f.read()
        matches = re.findall(r'-\s+([a-zA-Z0-9_-]+\.qmd)', content)
        for m in matches:
            if m not in chapters:
                chapters.append(m)
    return chapters

def get_valid_citations():
    valid = set()
    if not os.path.exists('networks.bib'):
        print("Warning: networks.bib not found.")
        return valid
        
    # Read bib file, matching any entry start e.g. @article{key,
    with open('networks.bib', 'r', encoding='utf-8') as f:
        for line in f:
            # Match lines starting with @something{key,
            # Allow leading whitespace
            match = re.match(r'^\s*@[a-zA-Z]+\s*\{\s*([^,\s]+)\s*,', line)
            if match:
                valid.add(match.group(1).strip())
    return valid

def check_citations():
    chapters = get_active_chapters()
    valid_keys = get_valid_citations()
    print(f"Checking citations across {len(chapters)} active chapters against {len(valid_keys)} BibTeX keys...")
    
    # Standard Quarto crossref prefixes to ignore (not citations)
    crossref_prefixes = {'fig', 'tbl', 'sec', 'eq', 'thm', 'lem', 'cor', 'prp', 'cnj', 'def', 'exm', 'rem'}
    
    # We want to match citations like:
    # 1. [@key] or [@key1; @key2] or [-@key]
    # 2. @key
    # Keys can contain letters, numbers, underscores, dashes, dots, colons, slashes, etc.
    # But they shouldn't include trailing sentence punctuation if matched inline.
    
    # Let's extract potential citation keys
    missing_citations = []  # list of (key, file, line_num, line_text)
    
    for f in chapters:
        if not os.path.exists(f):
            continue
        try:
            with open(f, 'r', encoding='utf-8') as file:
                in_code_block = False
                for line_idx, line in enumerate(file, 1):
                    stripped = line.strip()
                    if stripped.startswith('```'):
                        in_code_block = not in_code_block
                        continue
                    if in_code_block:
                        continue

                    # Find all @key matches
                    # Look behind to make sure it's not part of an email or word
                    # Key can contain alphanumeric, _, -, ., /, :, etc.
                    matches = re.finditer(r'(?<!\w)@([a-zA-Z0-9_./:$%+_-]+)', line)
                    for match in matches:
                        raw_key = match.group(1)
                        # Strip trailing sentence punctuation or brackets
                        key = raw_key.rstrip('.,;:!?)]}')
                        
                        # Check if it starts with a crossref prefix (e.g. fig-something)
                        if '-' in key:
                            prefix = key.split('-', 1)[0]
                            if prefix in crossref_prefixes:
                                continue
                                
                        # Skip if it is an empty key or some special math or formatting sequence
                        if not key or key.lower() == 'ref':
                            continue
                            
                        # If it looks like a valid citation key but not in bib file
                        if key not in valid_keys:
                            missing_citations.append((key, f, line_idx, line.strip()))
        except Exception as e:
            print(f"Error reading {f}: {e}")
            
    # Print results
    # Remove duplicates for the same key in the same file/line
    unique_missing = []
    seen = set()
    for item in missing_citations:
        seen_key = (item[0], item[1], item[2])
        if seen_key not in seen:
            seen.add(seen_key)
            unique_missing.append(item)
            
    if unique_missing:
        print(f"\n[ERROR] Found {len(unique_missing)} potentially missing/broken bibliography citations:")
        unique_missing.sort(key=lambda x: (x[1], x[2]))
        current_file = ""
        for key, file, line_num, line_text in unique_missing:
            if file != current_file:
                print(f"\nFile: {file}")
                current_file = file
            print(f"  Line {line_num:3d}: @{key}")
            print(f"            Text: {line_text}")
    else:
        print("\n[SUCCESS] No broken bibliography citations found in active chapters!")

    return len(unique_missing) == 0

if __name__ == '__main__':
    success = check_citations()
    sys.exit(0 if success else 1)
