import os
import re

def main():
    qmd_pattern = re.compile(r'library\(\s*["\']?([a-zA-Z0-9\._]+)["\']?\s*\)')
    packages = set()
    
    root_dir = r"C:\Users\Omar Lizardo\Google Drive\UCLA\networks-textbook"
    for r_dir, dirs, files in os.walk(root_dir):
        # Skip git and cache directories
        if ".git" in r_dir or ".quarto" in r_dir or "_sites" in r_dir:
            continue
        for file in files:
            if file.endswith('.qmd'):
                path = os.path.join(r_dir, file)
                try:
                    with open(path, "r", encoding="utf-8") as f:
                        for line in f:
                            match = qmd_pattern.search(line)
                            if match:
                                packages.add(match.group(1))
                except Exception as e:
                    print(f"Error reading {path}: {e}")
                    
    print("Found R packages imported in QMD files:")
    print(sorted(list(packages)))
    
    installed_packages = {
        'ggraph', 'tidygraph', 'igraph', 'kableExtra', 'signnet', 
        'dplyr', 'colorspace', 'patchwork', 'expm'
    }
    
    missing = packages - installed_packages - {'ggplot2', 'stats', 'base', 'gridExtra'} # ggplot2 is installed with ggraph, stats/base are standard
    print("\nPotentially missing packages in publish.yml:")
    print(sorted(list(missing)))

if __name__ == "__main__":
    main()
