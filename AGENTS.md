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
- `homeworks/`: Course homework source assignments (`homework{1..9}.qmd`). Rendered locally using `./render_homeworks.sh` and synced directly to UCLA Bruin Learn (Canvas LMS). Homeworks are explicitly excluded from public web publishing.
- `scraps/`: Drafts, retired chapters, and working fragments excluded from the book build.

## Chapter Inventory
Ordered per `book: chapters:` in `_quarto.yml`. Titles are pulled from each file's first `#` heading or YAML `title:` field — regenerate this table if chapters are added, renamed, or reordered rather than hand-editing it.

**Introduction to Networks**
| File | Title |
|---|---|
| `lesson-theory-what-are-networks.qmd` | What Are Networks? |
| `lesson-theory-what-are-social-networks.qmd` | What is A *Social* Network? |
| `lesson-theory-ties-bound.qmd` | Social Ties and Network Boundaries |
| `lesson-theory-tie-strength.qmd` | Tie Strength |
| `lesson-theory-multiplex.qmd` | Multiplex Networks |

**Networks and Graphs**
| File | Title |
|---|---|
| `lesson-graphs-intro.qmd` | Introduction to Graphs |
| `lesson-graphs-ties.qmd` | Types of Ties and Their Graphs |
| `lesson-graphs-dyads-triads.qmd` | Dyads and Triads |
| `lesson-graphs-metrics.qmd` | Basic Graph Metrics |
| `lesson-graphs-directed.qmd` | Directed Graphs |
| `lesson-graphs-paths.qmd` | Indirect Connections |
| `lesson-graphs-connectivity.qmd` | Graph Connectivity |
| `lesson-graphs-trees.qmd` | Tree Graphs |

**Networks and Matrices**
| File | Title |
|---|---|
| `lesson-matrix-intro.qmd` | Introduction to Matrices |
| `lesson-matrix-network.qmd` | The Social Network Matrices |
| `lesson-matrix-operations.qmd` | Basic Matrix Operations |
| `lesson-matrix-multiplication.qmd` | Matrix Multiplication and its Applications |

**Centrality and Status**
| File | Title |
|---|---|
| `lesson-sna-degree-centrality.qmd` | Centralities based on Degree |
| `lesson-sna-closeness.qmd` | Centralities based on the Geodesic Distance |
| `lesson-sna-betweenness.qmd` | Centralities based on Shortest Paths |
| `lesson-sna-bigthree.qmd` | The "Big Three" Centrality Metrics |
| `lesson-sna-eigenvector.qmd` | Getting Centrality from Others |
| `lesson-sna-status.qmd` | Status |
| `lesson-sna-hubs-and-authorities.qmd` | Hubs and Authorities |

**Two-Mode & Ego Networks**
| File | Title |
|---|---|
| `lesson-sna-affiliation-networks.qmd` | Affiliation Networks |
| `lesson-sna-ego-networks.qmd` | Ego Network Metrics |
| `lesson-sna-ego-collect.qmd` | Collecting Ego-Network Data |
| `lesson-theory-ego-homo.qmd` | Theories of Ego Network Homogeneity and Diversity |
| `lesson-theory-network-cognition.qmd` | Network Cognition and Cognitive Social Structures |

**Subgroups and Blocks**
| File | Title |
|---|---|
| `lesson-sna-groups-cliques.qmd` | Clique Analysis |
| `lesson-sna-groups-cohesive.qmd` | Cohesive Subsets |
| `lesson-theory-struct-equiv.qmd` | Equivalence and Similarity |
| `lesson-positions-advanced-equiv.qmd` | Automorphic and Regular Equivalence |
| `lesson-sna-local-similarity.qmd` | Local Node Similarities |
| `lesson-sna-blockmodeling.qmd` | Blockmodeling |

**Network Theory: Ties and Circles**
| File | Title |
|---|---|
| `lesson-theory-dunbar.qmd` | Dunbar's Theory of Social Circles |
| `lesson-theory-swt.qmd` | The Strength of Weak Ties |
| `lesson-theory-sht.qmd` | Structural Holes and Brokerage |
| `lesson-theory-smt.qmd` | Simmelian Tie Theory |

**Network Theory: Balance and Hierarchy**
| File | Title |
|---|---|
| `lesson-theory-balance-dyadic.qmd` | Dyadic Balance |
| `lesson-theory-balance-triadic.qmd` | Triadic Balance |
| `lesson-theory-balance-struct.qmd` | Structural Balance |
| `lesson-theory-valenced-interactions.qmd` | Theories of Valenced Interactions |
| `lesson-theory-hierarchies.qmd` | Dominance Hierarchies |

**Network Theory: Dynamics and Diffusion**
| File | Title |
|---|---|
| `lesson-theory-cycle-avoidance.qmd` | Micro Rules and Macro Structure: Four-Cycle Avoidance |
| `lesson-theory-diffusion.qmd` | The Diffusion of Innovations |
| `lesson-theory-small-world.qmd` | The Small World Phenomenon |

Front/back matter: `index.qmd`, `references.qmd`.

## Slide Deck Inventory
Slide decks in `slides/` are standalone Reveal.js decks (not ordered by `_quarto.yml`), each roughly paired with one or more chapters above.

| File | Title |
|---|---|
| `slides/what-are-networks.qmd` | What are Networks? |
| `slides/ties-motifs.qmd` | Ties, Dyads, and Triads |
| `slides/graph-theory.qmd` | Graph Theory |
| `slides/graph-metrics.qmd` | Graph Metrics |
| `slides/graph-connectivity.qmd` | Graph Theory: Paths & Connectivity |
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
1. **Edit assignment:** Modify `homeworks/homework{1..9}.qmd`.
2. **Render locally:** Run `./render_homeworks.sh [hw_number]`
   ```bash
   ./render_homeworks.sh 1       # Render Homework 1
   ./render_homeworks.sh         # Render all Homeworks (1-9)
   ```
   This generates `homeworks/homework{i}.html` and diagram figures in `homeworks/homework{i}_files/figure-html/`.
3. **Sync to Bruin Learn:** From the sibling repository (`../SOCIOL 111`):
   ```bash
   python3 sync_homeworks_to_canvas.py --dry-run --hw 1   # Preview changes
   python3 sync_homeworks_to_canvas.py --hw 1             # Push update live
   ```
   *Note:* The sync script automatically detects and reads from this local repository (`../networks-textbook`) for instant updates. Pass `--remote` to force fetching from GitHub if needed.
4. **Security & Privacy:** Homework assignments and answer keys must never be published to `_sites/` or exposed on the public site. The legacy numeric suffix hack (`*-5562048*`) and `render_homeworks.ps1` have been retired.

### 3. Continuous Integration & Deployment (CI/CD)
The `.github/workflows/publish.yml` pipeline runs on `ubuntu-latest` upon push to `main`:
1. **Pre-render Validation:**
   - `python check_book_refs.py`: Verifies that all active chapters listed in `_quarto.yml` have properly defined cross-references (figures, tables, sections, equations). Fails the build on broken refs.
   - `python check_book_citations.py`: Verifies that all bibliography citation keys used in active chapters exist in `networks.bib`. Fails the build on missing bib keys.
2. **Fast R Dependency Installation:** Uses `r-lib/actions/setup-r@v2` with Posit Public Package Manager (P3M) binary packages (`use-public-rspm: true`), completing dependency install in seconds.
3. **Book Build:** Renders book chapters to `_sites/`.
4. **Slide Decks Build:** Renders `slides/*.qmd` into `_sites/slides/`.
5. **Deployment:** Deploys `_sites/` to GitHub Pages.

## AI Agent Guidelines
- **Adding Chapters:** When creating a new chapter, use established file naming conventions and integrate the file into `_quarto.yml` under `book: chapters:`.
- **Canvas Assignment Links:** When lessons conclude a topic with an associated homework, include a callout tip pointing students to the specific assignment on Bruin Learn (`::: {.callout-tip} ## Associated Assignment on Bruin Learn ... :::`).
- **Slide Image References:** Slide decks in `slides/` must reference root images as `../images/<filename>`. Root `images/` is registered under `project.resources` in `_quarto.yml` to guarantee availability on the deployed site.
- **R Code Execution:** Before running complex operations, ensure the active R environment has necessary packages loaded (`renv::restore()`).
- **Context:** This is an educational resource. Explanations of code, concepts, and network theory should be clear and accessible for students.
