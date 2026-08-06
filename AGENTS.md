# Social Networks Textbook Agent Memory

## Project Overview
This repository contains the source code for an introductory textbook on social network analysis titled **"Social Networks: An Introduction"** by Omar Lizardo and Isaac Jilbert. It is structured and built as a Quarto book.

## Tech Stack
- **Framework:** Quarto (Book project type)
- **Language:** R
- **Environment Management:** `renv` (R environment)
- **Build Output:** The site renders to `_sites/`

## Project Structure
- `*.qmd`: Quarto markdown files containing the lessons. They follow a naming convention organized by topic:
  - `lesson-graphs-*.qmd`
  - `lesson-matrix-*.qmd`
  - `lesson-positions-*.qmd`
  - `lesson-sna-*.qmd`
  - `lesson-theory-*.qmd`
- `_quarto.yml`: Quarto configuration, detailing the book structure, chapters, and rendering rules.
- `networks.bib`: Bibliography file containing references/citations for the textbook.
- `renv.lock` / `renv/`: R environment lockfile and project library.
- `slides/` & `homeworks/`: Additional course resources included in the build via `_quarto.yml`.

## Common Tasks & Workflows
- **Rendering the book:** Use the `quarto render` command (or the IDE build tools) to generate the book into the `_sites/` directory. Note that the Quarto render configuration explicitly ignores files matching `!*_*.qmd_`, `!*-5562048.qmd`, and everything in `!scraps/**`.
- **Managing Dependencies:** Dependencies are managed via `renv`. If new packages are added in an R session, remember to document them and potentially run `renv::snapshot()` if environment updates are needed. Run `renv::restore()` to install current dependencies.
- **Network Visualizations:** R code heavily features network plotting tools (e.g., `ggraph`, `igraph`, `tidygraph`). `theme_graph()` is frequently used for styling.
- **Validating References and Citations:**
  - `python3 check_book_refs.py`: Runs validation checking that all active chapters listed in `_quarto.yml` have properly defined cross-references (such as figures, tables, sections, and equations).
  - `python3 check_book_citations.py`: Verifies that all bibliography citation keys used in active chapters are present and defined in `networks.bib`.

## AI Agent Guidelines
- **Adding Chapters:** When creating a new chapter or lesson, use the existing `.qmd` naming conventions and ensure the new file is appropriately integrated into the table of contents in `_quarto.yml`.
- **R Code Execution:** Before running complex operations, ensure the active R environment has the necessary packages loaded. 
- **Context:** Remember that this is an educational resource. Explanations of code, concepts, and network theory should be clear and accessible for students.