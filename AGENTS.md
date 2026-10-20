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
| `slides/matrix-operations.qmd` | Matrix Algebra in Social Networks: Part I (Basic Operations, Transpose, Dyad Census) |
| `slides/matrix-multiplication.qmd` | Matrix Algebra in Social Networks: Part II (Multiplication, Conformability, Applications) |
| `slides/matrix-advanced.qmd` | Advanced Network Matrices |
| `slides/ego-metrics.qmd` | Measuring Ego Networks |
| `slides/ego-homogeneity.qmd` | Theories of Ego Network Homogeneity and Diversity |
| `slides/cognitive-social-structures.qmd` | Cognitive Social Structures |
| `slides/affiliation-networks.qmd` | Affiliation Networks |
| `slides/centrality.qmd` | Centrality in Networks |
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

### 4. Slide Overflow QA (verified 2026-10-15)
Policy: no slide in a Reveal.js deck may scroll vertically; if content genuinely doesn't fit, split it into two consecutive slides rather than shrinking fonts aggressively.

**Minimum visibility floors for figures and tables (added 2026-10-20).** Every graph/figure and matrix/table in a slide deck must stay above these thresholds — do not shrink below them to fit content; instead split the slide, rebalance columns, or move content into the column with slack:
- **Figures (ggraph/ggplot):** minimum `fig-width`/`fig-height` of **3.5in** when square and kept equal (so layouts don't distort); a 3.3in figure is tolerable only inside a narrow (~30%) side column. Wide multi-panel strips (e.g. the MAN dyad triptych at 8in wide) need at least **2.9in** height. Node points ≥ size 15 and node labels ≥ size 7 in ggraph plots; paired-edge arrowheads ≥ 3.5mm with `end_cap` ≥ 6mm so arrowheads stay visible (small open arrowheads read as undirected ties — cost a real fix in matrix-advanced).
- **kable tables:** `font_size` ≥ **18** (20 preferred for the primary worked-example matrices). A one-off 16 is allowed only for secondary tables in narrow columns.
- **Rule of thumb:** if a figure or table needs squinting, the slide is overfull — split it or restructure the columns rather than shrink the exhibit. When a worked example references a graph or matrix, the referenced exhibit must be visible on the same slide (the persistent-example-graph convention used in affiliation-networks and matrix-advanced).

**Measuring overflow:** `scrollable: true` makes overflowing slides scroll, so check empirically instead of by eye. Render the deck, then measure each slide's `scrollHeight` vs `clientHeight` at the deck's native 1280×720 geometry in headless Chrome. No browser is installed in the Crostini container; the working setup (cached under a scratch dir, Node 18-compatible):
```bash
npx -y @puppeteer/browsers@2.4.1 install chrome-headless-shell@stable   # latest installer needs Node >= 20
npm i puppeteer-core                                                     # v25 is ESM-only: use dynamic import()
```
Drive it with `Reveal.slide(h, v)` per slide (decks nest `##` slides inside `#` part sections — `.slides > section` alone only sees part headers), wait for `Reveal.isReady()` + `MathJax.startup.promise` + `document.fonts.ready` first. A slide scrolls iff `scrollHeight > clientHeight` and its computed `overflow-y` is `auto`/`scroll`. `scrollHeight`/`clientHeight` ignore Reveal's CSS transform scale, so results are resolution-independent. `# Part N` divider slides report a small scrollHeight delta but are `overflow-y: visible` and shrink-wrapped — they never scroll; ignore them. Quarto's own `scrollable` class on a section is only a heuristic; trust the measurement.

**Quarto/Pandoc pitfalls (both verified 2026-10-15, cost real debugging time):**
1. A raw `<div style=...>` wrapper must open and close **within** a single `:::` fenced div. If `</div>` lands after the wrapper's parent `:::` closes (straddling the boundary), pandoc mis-pairs the fences and silently swallows the remainder of the deck — the render still prints "Output created" but with a fraction of the slides and a `Div ... unclosed` WARNING. Always check the render log for that warning. Raw `<div>` around plain markdown (tables, bullets) inside a column is fine.
2. `::: {.column width="60%" style="font-size: 85%;"}` fails: Quarto emits its own `style="width:60%"` and drops the custom style ("Ignoring duplicate attribute" warning). Put everything in `style` instead: `::: {.column style="width: 60%; font-size: 85%;"}`.

**Layout facts that drive overflow in `slides/`:** `ucla-theme.css` sets a 34px base font; its `p, li { font-size: 0.85em }` reduction does NOT apply to tables, so tables render at full size and are usually the tallest element — especially text tables in narrow columns (cells wrap one word per line). Effective fixes in order of preference: split the slide; move bullets into the column that has slack (e.g., under the figure); drop subheadings that duplicate the slide title ("### Matrix Progress", etc.); wrap a column's content in `<div style="font-size: 80-90%">` (72% is the established floor, used in matrix-operations); shrink square `fig-width/fig-height` together (keep them equal so graph layouts don't distort). As of 2026-10-15 all four matrix decks (matrix-intro, matrix-operations, matrix-multiplication, matrix-advanced) measure 0 scrolling slides; as of 2026-10-20 so do matrix-operations (with the new row/column-sums slides) and affiliation-networks. **Measure with all Reveal fragments advanced — but NEVER via a blind loop of `Reveal.next()`** (measuring at fragment 0 can miss overflow hidden behind `. . .` builds). VERIFIED 2026-10-20: `measure4.mjs` did `Reveal.slide(h, v, 0)` then `for (i < 40) Reveal.next()` — `Reveal.next()` moves to the NEXT SLIDE once fragments run out, so every measurement landed on a later slide and its "0 overflowing" verdicts were meaningless. The correct tool is `measure5.mjs` in the qa scratch dir: it reveals fragments by raising the fragment index with `Reveal.slide(h, v, f)` (f = number of `.fragment` elements), asserts it never left the target slide, and additionally checks every table's (or its `scroll_box` wrapper's) bottom edge against the slide bottom. Re-sweeping current decks with it (2026-10-20): centrality, affiliation-networks, ties-motifs, matrix-intro/operations/multiplication/advanced, valenced-interactions, graph-cutsets-directed all 0 slide + 0 table overflows. Deck-internal conventions that keep 19-row ranking tables from overflowing: `kbl2(df, font)` helper (defined in centrality.qmd setup) splits any node/score table into side-by-side halves, halving its height; and the 19-node example graph should use a fixed `graphlayouts` stress layout (`create_layout(gr19, layout = "stress")` coords stored once, passed via `layout = "manual"`) so the graph looks identical on every slide and labels never collide — FR layouts cram this graph's left cluster.

### 5. Bruin Learn (Canvas) API: Posting Announcements
Credentials are read from `~/.Renviron` (`CANVAS_API_TOKEN`, `CANVAS_URL`), same pattern as the sibling repo's scripts. Course ID for SOCIOL 111 is `238980`.

**Working pattern (verified 2026-10-13):** post via `POST /api/v1/courses/:course_id/discussion_topics` with a **form-encoded** body — `title`, `message` (HTML), `is_announcement=true`, `published=true`:
```bash
curl -X POST -H "Authorization: Bearer $TOKEN" \
  --data-urlencode "title=..." \
  --data-urlencode "message=<p>...</p>" \
  --data-urlencode "is_announcement=true" \
  --data-urlencode "published=true" \
  "https://bruinlearn.ucla.edu/api/v1/courses/238980/discussion_topics"
```
Verify the creation response's `is_announcement: true` (the documented `announcement` param is silently ignored — plain discussion fallback requires delete-and-recreate). This matches section "G. Posting Announcements" in `../SOCIOL 111/AGENTS.md`, which is the canonical doc for Bruin Learn operations.

**Route pitfalls (verified 2026-10-13):**
- `POST /api/v1/courses/:id/announcements`, and `POST`/`GET .../discussions` return a 404 HTML "Page Not Found" page with this token. An HTML 404 here is a wrong-route symptom, not an auth/CSRF problem — don't retry with token tricks.
- `POST /modules/:id/reorder` is a non-API, CSRF-protected route and always fails with a Bearer token. Reposition module items with `PUT /modules/:module_id/items/:item_id` + `{"module_item": {"position": N}}` instead.
- Newly created module items default to `published: false`; publish explicitly via `PUT .../items/:item_id` with `{"module_item": {"published": true}}`.
- `GET` on assignments and modules items works fine, so dates/order facts should be confirmed from the live API before communicating them to students.

## AI Agent Guidelines
- **Adding Chapters:** When creating a new chapter, use established file naming conventions and integrate the file into `_quarto.yml` under `book: chapters:`.
- **Canvas Assignment Links:** When lessons conclude a topic with an associated homework, include a callout tip pointing students to the specific assignment on Bruin Learn (`::: {.callout-tip} ## Associated Assignment on Bruin Learn ... :::`).
- **Slide Image References:** Slide decks in `slides/` must reference root images as `../images/<filename>`. Root `images/` is registered under `project.resources` in `_quarto.yml` to guarantee availability on the deployed site.
- **R Code Execution:** Before running complex operations, ensure the active R environment has necessary packages loaded. Use `renv::restore(prompt = FALSE)` — the confirmation prompt does not render in the Positron console and makes restore appear to hang. Restores are fast because the local renv binary cache is well populated.
- **Context:** This is an educational resource. Explanations of code, concepts, and network theory should be clear and accessible for students.
