# Social Networks Textbook Agent Memory

## Project Overview
This repository contains the source code for an introductory textbook on social network analysis titled **"Social Networks: An Introduction"** by Omar Lizardo and Isaac Jilbert. It is structured and built as a Quarto book.

## Tech Stack
- **Framework:** Quarto (Book project type)
- **Language:** R
- **Environment Management:** `renv` (R environment)
- **Build Output:** The site renders to `_sites/`
- **CI/CD:** GitHub Actions (`.github/workflows/publish.yml`) on `ubuntu-latest` deploying to GitHub Pages

## Project Structure
- `*.qmd`: Quarto markdown files containing the lessons. They follow a naming convention organized by topic:
  - `lesson-graphs-*.qmd`
  - `lesson-matrix-*.qmd`
  - `lesson-positions-*.qmd`
  - `lesson-sna-*.qmd`
  - `lesson-theory-*.qmd`
- `_quarto.yml`: Quarto configuration, detailing the book structure and chapters. Only chapters listed in `book: chapters:` are built into the textbook.
- `networks.bib`: Bibliography file containing references/citations for the textbook.
- `renv.lock` / `renv/`: R environment lockfile and project library.
- `slides/`: Reveal.js slide decks for course lectures. Rendered into `_sites/slides/` during publishing.
- `homeworks/`: Source Quarto assignments (`homework{1..9}.qmd`). Rendered locally using `./render_homeworks.sh` and synced directly to Canvas LMS (Bruin Learn) via `SOCIOL 111/sync_homeworks_to_canvas.py`. Homeworks are kept off the public textbook site.
- `scraps/`: Drafts, retired chapters, and working fragments excluded from the book build.

## Common Tasks & Workflows
- **Rendering the book:** Run `quarto render` (or use IDE build tools). Quarto automatically renders the chapters defined under `book: chapters:` in `_quarto.yml`.
- **Rendering homeworks:** Run `./render_homeworks.sh [hw_number]` (e.g., `./render_homeworks.sh 1` or `./render_homeworks.sh` for all) to generate the HTML and figures used by Bruin Learn.
- **Managing Dependencies:** Dependencies are managed via `renv`. Run `renv::restore()` to install dependencies and `renv::snapshot()` after adding packages.
- **Validating References and Citations:**
  - `python3 check_book_refs.py`: Verifies that all active chapters listed in `_quarto.yml` have properly defined cross-references (figures, tables, sections, equations).
  - `python3 check_book_citations.py`: Verifies that all bibliography citation keys used in active chapters exist in `networks.bib`.
  - Both validation scripts return exit code 0 on success and are enforced as pre-render gates in CI.

## AI Agent Guidelines
- **Adding Chapters:** When creating a new chapter, use established file naming conventions and integrate the file into `_quarto.yml` under `book: chapters:`.
- **Homework Updates:** Homework assignments are maintained in `homeworks/homework{1..9}.qmd`. Never publish homework solutions or answer keys to `_sites/` or the public web.
- **Slide Paths:** Slide decks in `slides/` should reference root images as `../images/<filename>`. Root `images/` is registered in `_quarto.yml` under `project.resources` to ensure availability on the deployed site.
- **Context:** Remember that this is an educational resource. Explanations of code, concepts, and network theory should be clear and accessible for students.
