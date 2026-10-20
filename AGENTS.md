# Social Networks Textbook Agent Memory

## Project Overview
This repository contains the source code for an introductory textbook on social network analysis titled **"Social Networks: An Introduction"** by Omar Lizardo and Isaac Jilbert. It is structured and built as a Quarto book.

## Tech Stack
- **Framework:** Quarto (Book project type)
- **Language:** R
- **Environment Management:** `renv` (R environment)
- **Build Output:** The public book site renders to `_sites/`
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
- `homeworks/`: Course homework assignments (`homework{1..9}.qmd`). **Legacy location (2026-09-23 migration):** the primary homework sources now live in the sibling repo `../SOCIOL-111/homeworks/`; this directory is a fallback that the Canvas sync script reads only if the sibling copy is absent. Rendered locally using `./render_homeworks.sh` and synced directly to UCLA Bruin Learn (Canvas LMS). Homeworks are explicitly excluded from public web publishing.
- `scraps/`: Drafts, retired chapters, and working fragments excluded from the book build.

## Chapter Inventory
Ordered per `book: chapters:` in `_quarto.yml`. Titles are pulled from each file's first `#` heading or YAML `title:` field — regenerate this table if chapters are added, renamed, or reordered rather than hand-editing it.

**Introduction to Networks**
| File | Title |
|---|---|
| `01-theory-what-are-networks.qmd` | What Are Networks? |
| `02-theory-what-are-social-networks.qmd` | What is A *Social* Network? |
| `03-theory-ties-bound.qmd` | Social Ties and Network Boundaries |
| `04-theory-tie-strength.qmd` | Tie Strength |
| `05-theory-multiplex.qmd` | Multiplex Networks |

**Networks and Graphs**
| File | Title |
|---|---|
| `06-graphs-intro.qmd` | Introduction to Graphs |
| `07-graphs-ties.qmd` | Types of Ties and Their Graphs |
| `08-graphs-dyads-triads.qmd` | Dyads and Triads |
| `09-graphs-metrics.qmd` | Basic Graph Metrics |
| `10-graphs-directed.qmd` | Directed Graphs |
| `11-graphs-paths.qmd` | Indirect Connections |
| `12-graphs-connectivity.qmd` | Graph Connectivity |
| `13-graphs-trees.qmd` | Tree Graphs |

**Networks and Matrices**
| File | Title |
|---|---|
| `14-matrix-intro.qmd` | Introduction to Matrices |
| `15-matrix-network.qmd` | The Social Network Matrices |
| `16-matrix-operations.qmd` | Basic Matrix Operations |
| `17-matrix-multiplication.qmd` | Matrix Multiplication and its Applications |

**Centrality and Status**
| File | Title |
|---|---|
| `18-sna-degree-centrality.qmd` | Centralities based on Degree |
| `19-sna-closeness.qmd` | Centralities based on the Geodesic Distance |
| `20-sna-betweenness.qmd` | Centralities based on Shortest Paths |
| `21-sna-bigthree.qmd` | The "Big Three" Centrality Metrics |
| `22-sna-eigenvector.qmd` | Getting Centrality from Others |
| `23-sna-status.qmd` | Status |
| `24-sna-hubs-and-authorities.qmd` | Hubs and Authorities |

**Two-Mode & Ego Networks**
| File | Title |
|---|---|
| `25-sna-affiliation-networks.qmd` | Affiliation Networks |
| `26-sna-ego-networks.qmd` | Ego Network Metrics |
| `27-sna-ego-collect.qmd` | Collecting Ego-Network Data |
| `28-sna-ego-homo.qmd` | Theories of Ego Network Homogeneity and Diversity |
| `29-sna-network-cognition.qmd` | Network Cognition and Cognitive Social Structures |

**Subgroups and Blocks**
| File | Title |
|---|---|
| `30-sna-groups-cliques.qmd` | Clique Analysis |
| `31-sna-groups-cohesive.qmd` | Cohesive Subsets |
| `32-sna-struct-equiv.qmd` | Equivalence and Similarity |
| `33-sna-advanced-equiv.qmd` | Automorphic and Regular Equivalence |
| `34-sna-local-similarity.qmd` | Local Node Similarities |
| `35-sna-blockmodeling.qmd` | Blockmodeling |

**Network Theory: Ties and Circles**
| File | Title |
|---|---|
| `36-theory-dunbar.qmd` | Dunbar's Theory of Social Circles |
| `37-theory-swt.qmd` | The Strength of Weak Ties |
| `38-theory-sht.qmd` | Structural Holes and Brokerage |
| `39-theory-smt.qmd` | Simmelian Tie Theory |

**Network Theory: Balance and Hierarchy**
| File | Title |
|---|---|
| `40-theory-balance-dyadic.qmd` | Dyadic Balance |
| `41-theory-balance-triadic.qmd` | Triadic Balance |
| `42-theory-balance-struct.qmd` | Structural Balance |
| `43-theory-valenced-interactions.qmd` | Theories of Valenced Interactions |
| `44-theory-hierarchies.qmd` | Dominance Hierarchies |

**Network Theory: Dynamics and Diffusion**
| File | Title |
|---|---|
| `45-theory-cycle-avoidance.qmd` | Micro Rules and Macro Structure: Four-Cycle Avoidance |
| `46-theory-diffusion.qmd` | The Diffusion of Innovations |
| `47-theory-small-world.qmd` | The Small World Phenomenon |

Front/back matter: `index.qmd`, `references.qmd`.

## Slide Deck Inventory
Slide decks in `slides/` are standalone Reveal.js decks (not ordered by `_quarto.yml`), each roughly paired with one or more chapters above.

| File | Title |
|---|---|
| `slides/what-are-networks.qmd` | What are Networks? |
| `slides/ties-motifs.qmd` | Ties, Dyads, and Triads |
| `slides/graph-theory.qmd` | Graph Theory |
| `slides/graph-metrics-undirected.qmd` | Undirected Graph Metrics |
| `slides/graph-metrics-directed.qmd` | Directed Graph Metrics |
| `slides/graph-paths-walks.qmd` | Graph Theory: Paths, Walks & Directed Connections |
| `slides/graph-cutsets-directed.qmd` | Graph Theory: Cutsets, Bridges & Directed Connectivity |
| `slides/graph-trees.qmd` | Graph Theory: Trees, Forests & Efficiency |
| `slides/matrix-intro.qmd` | Networks, Graphs, and Matrices |
| `slides/matrix-operations.qmd` | Matrix Algebra in Social Networks |
| `slides/matrix-advanced.qmd` | Advanced Network Matrices |
| `slides/ego-metrics.qmd` | Measuring Ego Networks |
| `slides/ego-homogeneity.qmd` | Theories of Ego Network Homogeneity and Diversity |
| `slides/cognitive-social-structures.qmd` | Cognitive Social Structures |
| `slides/subgroups.qmd` | Graph Theory: Sub-Groups & Cliques |
| `slides/positional-equivalence.qmd` | Graph Theory: Equivalence & Similarity |
| `slides/blockmodeling.qmd` | Graph Theory: Blockmodeling |
| `slides/dunbar-theory.qmd` | Dunbar's Theory of Social Circles |
| `slides/strength-weak-ties.qmd` | The Strength of Weak Ties |
| `slides/structural-holes.qmd` | Burt's Theory of Structural Holes |
| `slides/chains-of-affection.qmd` | Chains of Affection |
| `slides/balance-signed-graphs.qmd` | Balance Theory and Signed Graphs |
| `slides/valenced-interactions.qmd` | Theories of Valenced Interactions |
| `slides/small-world.qmd` | The Small World Phenomenon |

## Core Workflows

### 1. Rendering the Textbook
- Run `quarto render` (or use IDE build tools).
- Quarto automatically renders only the chapters defined under `book: chapters:` in `_quarto.yml`.
- Render output is placed into `_sites/`.

### 2. Homework Authoring & Canvas LMS Sync
Homework assignments are delivered privately to students via UCLA Bruin Learn (Canvas LMS) rather than published on the open web:
1. **Edit assignment:** Modify `homework{1..9}.qmd` in the sibling repo's `homeworks/` directory (`C:\projects\SOCIOL-111\homeworks`) — the primary source since 2026-09-23. This repo's `homeworks/` directory is a legacy fallback only.
2. **Render locally:** From this repo, run `./render_homeworks.sh [hw_number]`
   ```bash
   ./render_homeworks.sh 1       # Render Homework 1
   ./render_homeworks.sh         # Render all Homeworks (1-9)
   ```
   This generates `homeworks/homework{i}.html` and diagram figures in `homeworks/homework{i}_files/figure-html/`.
3. **Sync to Bruin Learn:** From the sibling repository (`../SOCIOL-111`, hyphenated folder name):
   ```bash
   python3 sync_homeworks_to_canvas.py --dry-run --hw 1   # Preview changes
   python3 sync_homeworks_to_canvas.py --hw 1             # Push update live
   ```
   *Note:* The sync script resolves homework sources in order: the sibling repo's own `homeworks/` directory (primary), then this local checkout (`../networks-textbook`, the legacy fallback — also settable via the `NETWORKS_TEXTBOOK_DIR` env var), then GitHub. Pass `--remote` to force fetching from GitHub if needed.
4. **Security & Privacy:** Homework assignments and answer keys must never be published to `_sites/` or exposed on the public site. The legacy numeric suffix hack (`*-5562048*`) and `render_homeworks.ps1` have been retired.

### 3. Continuous Integration & Deployment (CI/CD)
The `.github/workflows/publish.yml` pipeline runs on `ubuntu-latest` upon push to `main`:
1. **Pre-render Validation:**
   - `python check_book_refs.py`: Verifies that all active chapters listed in `_quarto.yml` have properly defined cross-references (figures, tables, sections, equations). Fails the build on broken refs.
   - `python check_book_citations.py`: Verifies that all bibliography citation keys used in active chapters exist in `networks.bib`. Fails the build on missing bib keys.
2. **Fast R Dependency Installation:** Uses `r-lib/actions/setup-r@v2` with Posit Public Package Manager (P3M) binary packages (`use-public-rspm: true`), completing dependency install in seconds.
3. **Book Build:** Renders book chapters to `_sites/`.
4. **Slide Decks Build:** Renders changed `slides/*.qmd` into `_sites/slides/`.
5. **Slide Size Floor Audit (non-blocking):** `python audit_slide_sizes.py --no-render` audits the changed decks (see workflow 5). Currently `continue-on-error: true`; flip to `false` to enforce once remaining figure violations are fixed.
6. **Deployment:** Deploys `_sites/` to GitHub Pages.

### 4. Slide Deck Size Floor (established 2026-10-20)
Slides must never render matrices or graphs below a minimum readable size on the 1280×720 canvas. Two enforcement layers:

**CSS floor** (`slides/ucla-theme.css`, end of file): `.reveal .math.display { font-size: max(1em, 34px) }` — display math never renders below the deck's 34px base font, no matter what shrinks its container (the theme's `0.85em` prose rule, callouts, `.smaller`). Before this, display math inherited the 0.85em prose shrink and rendered at 28.9px.

**Audit** (`audit_slide_sizes.py`, repo root): renders each deck in headless Chrome (MathJax must finish), measures real on-canvas element sizes, and flags:
- display math below 34px, wider than the 1024px usable width, or never typeset (raw LaTeX visible to students)
- figures displayed below 75% of natural raster size (plot text shrinks with the image) or below 300px wide

Usage: `python audit_slide_sizes.py slides/matrix-operations.qmd` (auto-renders stale decks), `--no-render` (audit existing HTML only, used in CI), `--warn-only`. Requires headless Chrome (auto-detected; `CHROME_BIN` overrides). Exit 1 on violations.

**Known remaining violations (as of 2026-10-20):** ~33 figures in `slides/matrix-operations.qmd` and `slides/matrix-advanced.qmd` are rendered at `fig-width: 7` (672px rasters) but displayed in ~263px columns (39% scale, ~6px labels). Fix by matching `fig-width` to the display column (~3.5) when touching those decks.

### 5. Bruin Learn (Canvas) API: Posting Announcements
Credentials are read from `~/.Renviron` (`CANVAS_API_TOKEN`, `CANVAS_URL`). Course ID for SOCIOL 111 is `238980`.

**File locations & format (on this Windows machine):**
- R reads `C:\Users\Omar Lizardo\OneDrive\Documents\.Renviron` (R's `~` is OneDrive Documents); it tolerates `KEY = value` with spaces.
- Shell/Python tools (including `sync_homeworks_to_canvas.py`) read `C:\Users\Omar Lizardo\.Renviron` via `os.path.expanduser`. The sync script's parser requires strict `KEY=value` lines — no spaces around `=` and no quotes — otherwise credentials are silently missed.

**Working pattern (verified 2026-10-13):** post via `POST /api/v1/courses/:course_id/discussion_topics` with a **form-encoded** body — `title`, `message` (HTML), `is_announcement=true`, `published=true`:
```bash
curl -X POST -H "Authorization: Bearer $TOKEN" \
  --data-urlencode "title=..." \
  --data-urlencode "message=<p>...</p>" \
  --data-urlencode "is_announcement=true" \
  --data-urlencode "published=true" \
  "https://bruinlearn.ucla.edu/api/v1/courses/238980/discussion_topics"
```
Verify the creation response's `is_announcement: true` (the documented `announcement` param is silently ignored — plain discussion fallback requires delete-and-recreate). This matches section "G. Posting Announcements" in `../SOCIOL-111/AGENTS.md`, which is the canonical doc for Bruin Learn operations.

**Route pitfalls (verified 2026-10-13):**
- `POST /api/v1/courses/:id/announcements`, and `POST`/`GET .../discussions` return a 404 HTML "Page Not Found" page with this token. An HTML 404 here is a wrong-route symptom, not an auth/CSRF problem — don't retry with token tricks.
- `POST /modules/:id/reorder` is a non-API, CSRF-protected route and always fails with a Bearer token. Reposition module items with `PUT /modules/:module_id/items/:item_id` + `{"module_item": {"position": N}}` instead.
- Newly created module items default to `published: false`; publish explicitly via `PUT .../items/:item_id` with `{"module_item": {"published": true}}`.
- `GET` on assignments and modules items works fine, so dates/order facts should be confirmed from the live API before communicating them to students.

## AI Agent Guidelines
- **Adding Chapters:** When creating a new chapter, use established file naming conventions and integrate the file into `_quarto.yml` under `book: chapters:`.
- **LaTeX matrix row separators:** Inside `$$\begin{pmatrix}...\end{pmatrix}$$` in slide decks, rows are separated by exactly two backslashes (`\\`). Four backslashes (`\\\\`) render as two row breaks in MathJax — empty rows that double matrix height (this bug affected 105 separators in `slides/matrix-operations.qmd`, fixed 2026-10-20).
- **Slide figure sizing:** Match chunk `fig-width` to the figure's displayed column width so plot text renders at ~1:1 (e.g., `fig-width: 3.5` for a ~263px half-column). Oversized rasters downscaled by the browser produce unreadably small labels, and `audit_slide_sizes.py` will flag them.
- **Canvas Assignment Links:** When lessons conclude a topic with an associated homework, include a callout tip pointing students to the specific assignment on Bruin Learn (`::: {.callout-tip} ## Associated Assignment on Bruin Learn ... :::`).
- **Slide Image References:** Slide decks in `slides/` must reference root images as `../images/<filename>`. Root `images/` is registered under `project.resources` in `_quarto.yml` to guarantee availability on the deployed site.
- **R Code Execution:** Before running complex operations, ensure the active R environment has necessary packages loaded. Use `renv::restore(prompt = FALSE)` — the confirmation prompt does not render in the Positron console and makes restore appear to hang. Restores are fast because the local renv binary cache is well populated.
- **Context:** This is an educational resource. Explanations of code, concepts, and network theory should be clear and accessible for students.
