import os

root_dir = r"C:\Users\Omar Lizardo\Google Drive\UCLA\networks-textbook"
labels = ["sec-subgraphs", "sec-graphtheory", "sec-trees"]
found_labels = {label: [] for label in labels}

for dirpath, dirnames, filenames in os.walk(root_dir):
    if any(p in dirpath for p in ['.git', '.quarto', '_freeze', '_sites', 'docs', '.posit', '.Rproj.user']):
        continue
    for filename in filenames:
        if filename.endswith('.qmd'):
            filepath = os.path.join(dirpath, filename)
            try:
                with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                    content = f.read()
                    for label in labels:
                        if label in content:
                            found_labels[label].append(filename)
            except Exception as e:
                pass

print("Search results for section labels:")
for label, files in found_labels.items():
    print(f"- {label} found in: {files}")
