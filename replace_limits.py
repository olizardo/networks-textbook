import os
import re

files_changed = 0
for filename in os.listdir('.'):
    if filename.endswith('.qmd'):
        with open(filename, 'r', encoding='utf-8') as f:
            content = f.read()
        
        lines = content.split('\n')
        new_lines = []
        changed_file = False
        
        for line in lines:
            if 'xlim' in line or 'ylim' in line:
                if '+' in line:
                    # Find all matches and replace them
                    new_line = re.sub(r'\s*\+\s*xlim\([^)]+\)', '', line)
                    new_line = re.sub(r'\s*\+\s*ylim\([^)]+\)', '', new_line)
                    
                    if new_line != line:
                        new_line += ' + coord_cartesian(clip = "off")'
                        changed_file = True
                        line = new_line
            new_lines.append(line)
            
        if changed_file:
            with open(filename, 'w', encoding='utf-8') as f:
                f.write('\n'.join(new_lines))
            files_changed += 1

print("Changed " + str(files_changed) + " files")
