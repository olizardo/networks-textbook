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
- `*.qmd`: Quarto markdown files containing the lessons, named `NN-<topic>-<slug>.qmd` where `NN` is the book order and `<topic>` is one of `theory`, `graphs`, `matrix`, `sna` (see the Chapter Inventory below).
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
1. **Edit assignment:** Modify `homework{1..9}.qmd` in the sibling repo's `homeworks/` directory (`../SOCIOL-111/homeworks/`) — the primary source since 2026-09-23. If the sibling repo is not checked out on the current machine, this repo's legacy `homeworks/` copy is the fallback (or `--remote`; per-machine checkout status lives in user memory).
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
5. **Slide Size Floor Audit (non-blocking):** `python audit_slide_sizes.py --no-render` audits the changed decks (see workflow 4). Currently `continue-on-error: true`; all figure/size violations were cleared 2026-10-20/21 (0 remaining), so flipping to `false` to enforce is now a plain decision whenever desired.
6. **Deployment:** Deploys `_sites/` to GitHub Pages.

**Deploy concurrency guard (added 2026-10-21):** the workflow has `concurrency: { group: gh-pages-deploy, cancel-in-progress: true }` because the peaceiris deploy pushes to `gh-pages` non-forced, and two pushes to `main` inside a ~3-minute build window used to race (both fetched the same `gh-pages` head; the second push was rejected non-fast-forward — this actually failed the "agento II" run on 2026-10-21, benignly, since the two commits differed only in `AGENTS.md`). Under the guard, a newer run cancels the superseded one, so superseded runs show as **"cancelled", not "failure"** — that is expected, not a deploy failure.

### 4. Slide Deck Size Floor (established 2026-10-20, refined same day)
Slides must never render matrices or graphs below a minimum readable size on the 1280×720 canvas. Two enforcement layers:

**CSS floor** (`slides/ucla-theme.css`, end of file):
- `.reveal .math.display { font-size: max(1em, 34px) }` — display math never renders below the deck's 34px base font, no matter what shrinks its container (the theme's `0.85em` prose rule, callouts, `.smaller`).
- `.reveal .math-dense .math.display { font-size: max(1em, 20.8px) }` — inside an explicitly marked **dense** wrapper (`<div class="math-dense" style="font-size: NN%;">`, the overflow-QA shrink convention from workflow 5), display math follows the wrapper's size like other content but never below 20.8px (72% of the 28.9px prose size). Any deliberate font-size shrink div must carry `class="math-dense"` or the 34px floor will inflate its equations and re-overflow the slide.

**Audit** (`audit_slide_sizes.py`, repo root): renders each deck in headless Chrome (waits for MathJax to typeset every display span and for all images to load), measures real on-canvas element sizes, and flags:
- display math below the 34px floor (20.8px inside `.math-dense`), wider than the 1024px usable width, or never typeset (raw LaTeX visible to students)
- figures displayed below 75% of their **intended** size (the knitr `width` attribute = fig-width in CSS px; rasters are 2× retina, so never compare displayed px against the raw raster) or authored below the 3.3in minimum

Measurement essentials (each cost a real debugging round):
- Normalize by `Reveal.getScale()`: `getBoundingClientRect` includes the deck's global transform, and headless Chrome at default DPR ≠ 1 (e.g. 1.25 → 0.744 deck scale → everything measured ~26% small). The audit passes `--force-device-scale-factor=1` and divides by the scale anyway.
- Measure the `span.MathJax` inside `MathJax_Display`, not the div — the div is a full-width block and reports container width, not equation width.
- The injected measurement script lives in the audit; the instrumented copy must be written **next to the deck** (relative `*_files/` resources break from a temp dir).

Usage: `python audit_slide_sizes.py slides/matrix-operations.qmd` (auto-renders stale decks), `--no-render` (audit existing HTML only, used in CI), `--dump PATH` (raw measurements JSON), `--warn-only`. Requires headless Chrome (auto-detected; `CHROME_BIN` overrides). Exit 1 on violations.

**Phantom-slide pitfall (found 2026-10-20):** a `---` slide break placed directly under a `$$...$$` line with no blank line makes pandoc parse the equation as a setext **heading** — the equation silently moves to its own auto-titled slide (id derived from the LaTeX) and renders at heading size (e.g. 1705px wide). Always put a blank line between display math (or a raw `</div>`) and `---`.

**Status (2026-10-20, later):** matrix-operations (26 math blocks, 22 figures), graph-paths-walks, matrix-multiplication (5 dense-wrapped equations at 88% + figs bumped 3.0→3.3in), affiliation-networks (intersection equation split into a two-line `aligned` block), dunbar-theory, and strength-weak-ties (static images given explicit px `width` attributes matching their displayed column size) audit clean. The dense mechanism + equation splits (worked-example row/column sums, null-calc) cleared the earlier violations; the first "~39% figure scale" alarms were measurement artifacts (retina rasters + unnormalized deck scale), not real violations. **Remaining: 0 — all 26 measurable decks audit clean (2026-10-20, end of day).** The last 23 violations were cleared: ego-homogeneity (8 static PNGs) and structural-holes (4) got explicit px widths; ego-metrics' 1038px H_max equation lost its inline "where k..." parenthetical (moved to a bullet); matrix-advanced's sub-floor figures (3.1/2.7/2.9in) were bumped to 3.5/3.5/3.3in with arrowheads 3→3.5mm + end_caps 5→6mm (the fig growth re-overflowed Case 1/Case 3; fixed by moving the "No Zeros" bullet under the all-ones table and dropping Case 3's redundant intro line); oversized knitr strips were re-authored proportionally to their displayed size (graph-trees 12×4.5→8.8×3.3in, small-world 10×4.5→7×3.15in, graph-theory 9.5×5.5→5.6×3.25in, ties-motifs triad census 11×9→8.25×6.75in) so plot text renders ~1:1. **what-are-networks is UNMEASURABLE**: the merge added `embed-resources: true` (8.2MB single file with reveal+MathJax inlined) and headless Chrome produces an empty DOM dump at any budget — the audit reports "no measurements received" for it (the CI audit step is non-blocking and only audits changed decks). Retrofit recipe for static images: replace percentage/height sizing (`width="85%"`, `height="420px"`) with an explicit `width="NNNpx"` attribute equal to the image's real displayed width on the 1280×720 canvas (the audit reads the `width` attribute as the intended size and falls back to the full natural raster otherwise, so a 2400px retina export in a 590px column reads as a 25% violation); get the exact displayed width from `audit_slide_sizes.py --dump`, then declare a round value at or just below it. For knitr figures the same idea applies via chunk options: set `fig-width`/`fig-height` proportionally to the figure's real displayed size (a 12in strip displayed at 844px is a violation at 73%; re-authored at 8.8in it renders text ~1:1 and passes at 100%).

### 5. Slide Overflow QA (updated 2026-10-20)
Policy: no slide in a Reveal.js deck may scroll vertically; if content genuinely doesn't fit, split it into two consecutive slides rather than shrinking fonts aggressively.

**Minimum visibility floors for figures and tables (added 2026-10-20).** Every graph/figure and matrix/table in a slide deck must stay above these thresholds — do not shrink below them to fit content; instead split the slide, rebalance columns, or move content into the column with slack:
- **Figures (ggraph/ggplot):** minimum `fig-width`/`fig-height` of **3.5in** when square and kept equal (so layouts don't distort); a 3.3in figure is tolerable only inside a narrow (~30%) side column. Wide multi-panel strips (e.g. the MAN dyad triptych at 8in wide) need at least **2.9in** height. Node points ≥ size 15 and node labels ≥ size 7 in ggraph plots; paired-edge arrowheads ≥ 3.5mm with `end_cap` ≥ 6mm so arrowheads stay visible (small open arrowheads read as undirected ties — cost a real fix in matrix-advanced).
- **kable tables:** `font_size` ≥ **18** (20 preferred for the primary worked-example matrices). A one-off 16 is allowed only for secondary tables in narrow columns.
- **Rule of thumb:** if a figure or table needs squinting, the slide is overfull — split it or restructure the columns rather than shrink the exhibit. When a worked example references a graph or matrix, the referenced exhibit must be visible on the same slide (the persistent-example-graph convention used in affiliation-networks and matrix-advanced).

**Measuring overflow:** `scrollable: true` makes overflowing slides scroll, so check empirically instead of by eye. Render the deck, then measure each slide's `scrollHeight` vs `clientHeight` at the deck's native 1280×720 geometry in headless Chrome (the persistent chrome-headless-shell install; the QA scripts auto-prefer it and `CHROME_BIN` overrides).
```bash
npx -y @puppeteer/browsers@2.4.1 install chrome-headless-shell@stable   # latest installer needs Node >= 20
npm i puppeteer-core                                                     # v25 is ESM-only: use dynamic import()
```
Drive it with `Reveal.slide(h, v)` per slide (decks nest `##` slides inside `#` part sections — `.slides > section` alone only sees part headers), wait for `Reveal.isReady()` + `MathJax.startup.promise` + `document.fonts.ready` first. A slide scrolls iff `scrollHeight > clientHeight` and its computed `overflow-y` is `auto`/`scroll`. `scrollHeight`/`clientHeight` ignore Reveal's CSS transform scale, so results are resolution-independent. `# Part N` divider slides report a small scrollHeight delta but are `overflow-y: visible` and shrink-wrapped — they never scroll; ignore them. Quarto's own `scrollable` class on a section is only a heuristic; trust the measurement.

**Quarto/Pandoc pitfalls (both verified 2026-10-15, cost real debugging time):**
1. A raw `<div style=...>` wrapper must open and close **within** a single `:::` fenced div. If `</div>` lands after the wrapper's parent `:::` closes (straddling the boundary), pandoc mis-pairs the fences and silently swallows the remainder of the deck — the render still prints "Output created" but with a fraction of the slides and a `Div ... unclosed` WARNING. Always check the render log for that warning. Raw `<div>` around plain markdown (tables, bullets) inside a column is fine.
2. `::: {.column width="60%" style="font-size: 85%;"}` fails: Quarto emits its own `style="width:60%"` and drops the custom style ("Ignoring duplicate attribute" warning). Put everything in `style` instead: `::: {.column style="width: 60%; font-size: 85%;"}`.

**Layout facts that drive overflow in `slides/`:** `ucla-theme.css` sets a 34px base font; its `p, li { font-size: 0.85em }` reduction does NOT apply to tables, so tables render at full size and are usually the tallest element — especially text tables in narrow columns (cells wrap one word per line). Effective fixes in order of preference: split the slide; move bullets into the column that has slack (e.g., under the figure); drop subheadings that duplicate the slide title ("### Matrix Progress", etc.); wrap a column's content in `<div style="font-size: 80-90%">` (72% is the established floor, used in matrix-operations); shrink square `fig-width/fig-height` together (keep them equal so graph layouts don't distort). Overflow status (2026-10-20, per `measure6.mjs`): 0 slide + 0 table overflows in centrality, ties-motifs, matrix-intro, matrix-multiplication, valenced-interactions, graph-cutsets-directed, matrix-operations (46 slides), and matrix-advanced (36 slides) — the pending-fixes list from earlier on 2026-10-20 (matrix-operations "Working the Example"/"Transpose as a Reversed Graph"; matrix-advanced "Step 3", "Case 1", "Case 2", "Visualizing Node Eccentricity") is now cleared: the worked-example slide was split into separate Row Sums and Column Sums slides, and the others were fixed by trimming bullets and modest figure resizing within the visibility floors. **Re-check 2026-10-20 (post-merge, CSS force-visible scrollHeight check via `check_overflow.py`, same Chrome-injection pattern as `audit_slide_sizes.py` but forcing `section {display:block}` + `.fragment {visibility:visible}`): 5 overflowing slides surfaced, all pre-existing (none touched by that day's edits, likely arrived with the 18 remote merge commits):** affiliation-networks "Node Neighborhoods in Bipartite Graphs" (sh 771 > 720) and "Neighborhoods of the Other Mode" (sh 807); strength-weak-ties "Granovetter-Transitivity: Rule 1" (sh 800), "System-Level Consequences: Fragmented" (sh 753), and "Integrated" (sh 753). **All five fixed same day:** the affiliation slides were overflowing their TEXT column AND had display math spilling out of the column horizontally (a 981px equation in a 688px column — note display math can overflow its column onto the neighboring figure without tripping the 1024px slide-width audit check, so dense-wrap equations that near their column width); fix = rebalance columns to 60/40 + dense-wrap the N(...) equations (75% and 85%) + trim a line and a fragment marker. The swt slides were overflowing via the IMAGE column (650px-tall PNGs); fix = shrink the declared image widths (Rule 1 650→550px, system slides 650→600px). Post-fix check: 0 overflows in both decks, audit still clean. Companion scratch tool `dump_slide.py <html> <slide-id>...` prints per-element top/height/width for a slide — the diagnostic for finding which element pushes a slide over (same Chrome-injection pattern as the audit). The same check confirmed matrix-multiplication, dunbar-theory, and the affiliation-networks equation-split slide fit fine after the size-floor retrofit. **Fleet-wide overflow sweep (2026-10-20, end of day, same `check_overflow.py`): ~61 pre-existing overflowing slides across 18 decks, mostly introduced by the 18 remote merge commits and never previously audited** — subgroups (9), cognitive-social-structures (8), graph-metrics-undirected (5), graph-paths-walks (4), blockmodeling (4), chains-of-affection (4), ego-homogeneity (3), ego-metrics (3), graph-theory (3), graph-trees (3), matrix-operations (3), balance-signed-graphs (2), matrix-intro (2), centrality (2), positional-equivalence (2), structural-holes (2), ties-motifs (1), graph-metrics-directed (1). Confirmed clean: matrix-multiplication, matrix-advanced, dunbar-theory, strength-weak-ties, affiliation-networks, graph-cutsets-directed, valenced-interactions, small-world. what-are-networks is unmeasurable (embed-resources, see workflow 4). This backlog is the next QA project; fix priority = decks with sh > 800 first (cognitive-social-structures up to 2263, subgroups up to 1007, chains-of-affection up to 1047, blockmodeling up to 1628). **Measure with all Reveal fragments advanced — but NEVER via a blind loop of `Reveal.next()`** (measuring at fragment 0 can miss overflow hidden behind `. . .` builds). VERIFIED 2026-10-20: `measure4.mjs` did `Reveal.slide(h, v, 0)` then `for (i < 40) Reveal.next()` — `Reveal.next()` moves to the NEXT SLIDE once fragments run out, so every measurement landed on a later slide and its "0 overflowing" verdicts were meaningless. `measure5.mjs` fixed the fragment handling (raises the fragment index via `Reveal.slide(h, v, f)`, asserts it never left the target slide, checks every table's — or its `scroll_box` wrapper's — bottom edge against the slide bottom) but still raced lazy images and MathJax layout. The current standard is `measure6.mjs` in the qa scratch dir: measure5 plus (a) it waits for every `<img>` in the slide to finish loading — Quarto revealjs emits `data-src` lazy images, and an unloaded image reports height 0, corrupting the measurement — and (b) re-reads `scrollHeight` across 250 ms polls until it is stable. Companion `dump3.mjs <url> <h> <v>` prints settled per-element geometry (heights/tops of columns, tables, figures, fragments) for diagnosing exactly which element pushes a slide over. Deck-internal conventions that keep 19-row ranking tables from overflowing: `kbl2(df, font)` helper (defined in centrality.qmd setup) splits any node/score table into side-by-side halves, halving its height; and the 19-node example graph should use a fixed `graphlayouts` stress layout (`create_layout(gr19, layout = "stress")` coords stored once, passed via `layout = "manual"`) so the graph looks identical on every slide and labels never collide — FR layouts cram this graph's left cluster.

**Overflow backlog progress (2026-10-20, later session — RENDERED AND VERIFIED):** the three priority decks (worst sh first) were reworked, rendered, and pass both `check_overflow.py` (0 overflowing slides each) and `audit_slide_sizes.py` (0 violations each):
- **cognitive-social-structures.qmd:** root cause was mid-sentence `$$...$$` display math — pandoc gives each its own full display block (~80–100px per line, and stacked fragments hide them from fragment-0 measurements). Converted the mid-sentence ones to inline `$...$`, kept only standalone display equations. Verified clean.
- **subgroups.qmd:** Clique Affiliation Matrix, Edge Connectivity Matrix, and Node Connectivity Matrix slides converted to two-column layouts with tables at `font_size = 20`; Lambda Sets Steps 1–4 became bold inline labels with 4.2in figures; dendrogram at 5.8in; core-periphery figure 4.2in; k-core pruning slide two-column; "Comparing Meso-Level Structures" table wrapped in `<div style="font-size: 60%">` (= 20.4px rendered, above the 18px table floor). **body.jpg lesson:** bumping it 300→320px to clear the 3.3in floor re-overflowed its slide (sh 748) because the image is naturally 504×942 (tall aspect: 598px tall at 320px wide) and the Quarto `quarto-figure`/`p` wrapper adds ~57px of overhead below the img. Fix: replace the markdown image + fig-align with a **raw block-level `<img src="../images/body.jpg" width="320" style="display:block; margin: 0 auto;">`** inside the column — no figure/p wrapper, fits with ~30px slack, and the audit still reads the raw `width` attribute as intended size. A negative-margin wrapper div does NOT work here (flex column makes the wrapper box taller than its content).
- **blockmodeling.qmd:** CONCOR slide two columns; the blocked adjacency matrix split into two slides (Blocks 1–3: rows 1–15, and Blocks 4–7: rows 16–22) with `font_size = 20`; reduced image-matrix display equation dense-wrapped at 65%; image-matrix table at `font_size = 20`. **Hand-coded split offsets VERIFIED** against the seven-block partition: block order {I,J,K,L,M}, {N,O,P,Q,R}, {T,E,F,G,H}, {B,C}, {A,S}, {U,V}, {D} (sizes 5/5/5/2/2/2/1); row borders at 5/10/15 (slide 1) and local 2/4/6 (slide 2); column borders after columns 5/10/15/17/19/21 on both slides. All correct.
- **chains-of-affection.qmd (fixed and verified 2026-10-20, later session):** had 4 overflowing slides (up to sh 1047). Fixes: the "Structural Impossibility of Heterosexual 3-Cycles" slide was **split into two** (What-is-a-3-cycle + Bipartite Rule on one; The Catch + het/hom triangle figure + captions on a new "Closing the Triangle Requires a Same-Sex Tie" slide); the other three were fixed by condensing multi-line bullets (narrow 55%-column text wraps at only ~44 chars/line — budget accordingly) and by **removing a `. . .` fragment marker that rendered as a ~35px `<p>` + margins** on the 4-cycle slide (the figure then shows with the bullets instead of as a separate build). 0 overflow + 0 size violations after re-render.
- **BACKLOG CLEARED (2026-10-20, final session):** all remaining 38 overflowing slides across 15 decks were fixed, re-rendered, and verified — `check_overflow.py --all` now reports **0 overflowing slides across 26 measurable decks** (only what-are-networks skipped, still unmeasurable), and every edited deck also passes `audit_slide_sizes.py` (0 violations). Fixes applied, by deck: structural-holes (constraint slide → two columns; Obstfeld 838px table → split into Open/Closed slides + removed `<br>`s inside cells), ego-metrics (E-I range bullets consolidated; worked-example col trimmed + 90% wrapper; Blau/Clustering split into two slides), graph-metrics-undirected (stacked `$$` calcs merged to one line each; "Interpreting" split into two slides — **watch the fence arithmetic when splitting a `::::` columns block mid-slide: the first half needs its own `::::` closer before the `---`**, this bit the deck with an unclosed-Div warning that swallowed the rest of the file), ego-homogeneity (text-column trims; Feld's-rule bullet dropped from "Dimensions" — it is restated verbatim on the next slide; Hofstra col rebalanced 48/52), positional-equivalence (Three Coefficients → three-column formula layout; directed-cosine setup lines merged), centrality (Normalized Degree: intro/interpretation bullets trimmed, empty `. . .` marker removed; Relative Betweenness: definition/interpretation trimmed, both fragment markers removed), graph-trees (each two-line `$$` calc merged into one display line ×3), ties-motifs (dropped third asymmetric example, shortened note), graph-metrics-directed (directed-case display eq → inline), balance-signed-graphs (both triad-list columns wrapped in 85% divs — **the raw `<div>` must close BEFORE the column's `:::`**, the straddling pitfall cost a re-render), graph-paths-walks (small bullet trims; Connected-vs figures 4.5→4.2in), matrix-operations (Result slide: lead-in bullet folded into interpretation; Row/Column Sums directed line shortened; Transpose figures 3.9→3.85in for the last +1px; Dyad Census bullet 2 shortened), graph-theory (three "What is a Graph?" figures 6→5.9in — figure column drove the +6px), matrix-intro (symmetry/asymmetry figures 4.6→4.1in), matrix-advanced (Case 2 text col 85%→80% for the last +2px).
- **Recurring small-delta lesson:** marginal (+1 to +10px) overflows are cheapest to fix by trimming ONE wrap line of text, shrinking a figure by ~0.1in, or dropping an empty `. . .` fragment marker — not by restructuring.

**Re-verification on Crostini (2026-10-21):** after pulling the pushed fix commits (local was 10 commits behind), all 27 decks were re-rendered from current sources (Quarto 1.10.18, ~17s/deck) and re-audited: **0 overflowing slides across 27 decks and 0 size-floor violations** after one new fix — positional-equivalence "Adjacency Matrix of Equivalent Positions" (+1px, overflow via the 2-line bullet "Notice that Row A is identical...") was fixed by shortening the bullet to one line ("Rows A and B are identical (...), as are Rows C and D (...)"). The alarming first audit run (56 overflows / 45 size violations) measured STALE untracked HTML — the slides/*.html files are build artifacts not in git, so always re-render before auditing on a fresh checkout. Also: `slides/graph-connectivity.html` was an ORPHANED build artifact (source deck retired; its "Connected vs. Disconnected Graphs" content lives in graph-paths-walks.qmd) that produced a false +27px overflow alarm; it was deleted 2026-10-21 (a stray copy also exists at `_sites/slides/graph-connectivity.qmd`).

**Persistent-example conventions (2026-10-20, centrality + matrix-multiplication):** every slide that discusses the worked example keeps that example visible in a side column — explanations must stay visually anchored to the graph/matrix they refer to (user feedback: "disconnected textual examples" where the example disappears are hard to follow). Supporting helpers: pinned layouts (`create_layout(gr, "stress")` coords, or fixed circular coords passed via `layout = "manual"`) so the graph renders identically on every slide it appears on; `kbl2(df, font)` in centrality.qmd splits any node/score table into side-by-side halves, halving the height of 19-row rankings; matrix-multiplication.qmd has `g6(catmap, ...)` (6-node party graph; category colors: red/blue = focus nodes, green = shared friends, tan = others) and `kb6(m, font)` (bold rowname column), and its A×A′ traced-cell slides keep the FULL original matrices on screen with the active row/column highlighted in place via `row_spec(..., background =)` / `column_spec(..., background =)` (light red #F5B7B1 = left-matrix row, light blue #AED6F1 = right-matrix column) rather than showing bare extracted rows. Vertical-space fact: each MathJax display line costs ~80–100px — prefer merging a step-by-step calculation into ONE display line and moving the takeaway to a bullet, and never stack intro bullets above a columns block that already holds a figure + two matrices.

### 6. Bruin Learn (Canvas) API: Posting Announcements
Credentials are read from `~/.Renviron` (`CANVAS_API_TOKEN`, `CANVAS_URL`). Course ID for SOCIOL 111 is `238980`.

**Credentials format:** `~/.Renviron` holds `CANVAS_API_TOKEN` and `CANVAS_URL` (exact per-machine file locations: user memory). The sync script's parser requires strict `KEY=value` lines — no spaces around `=` and no quotes — otherwise credentials are silently missed.
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

## Open Items (2026-10-21)
- **Large tracked media (measured 2026-10-21):** tracked content totals ~402 MB — `_freeze/` 122 MB, `ppt_slides/` 101 MB (PowerPoints/ppts, incl. 13.8 MB `ppt_slides/Affiliation/Bipartite_Network_Algebra.pptx`), `WandF.pdf` 15 MB, `homeworks/` 10 MB, stray root `Affiliation Networks .pptx` (2 MB) and `Centrality.pptx` (1.4 MB). The chrome-headless-shell incident (272 MB committed in a first "pusho" attempt, amended out and `gc --prune=now`ed) showed how easily big files enter via a blanket `git add .`. If repo weight ever matters, `_freeze/` (knitr cache) and `ppt_slides/` are the big targets; GitHub rejects any single file >100 MB, so nothing currently blocks pushes.
- **Unverified deck edits:** none — every edited deck (cognitive-social-structures, subgroups, blockmodeling, chains-of-affection, plus all 15 backlog decks fixed in the final session) was rendered and verified: fleet-wide 0 overflow + 0 size violations across all 26 measurable decks. The overflow backlog is closed.
- **what-are-networks embed-resources:** the 18-commit remote merge added `embed-resources: true` to this deck (8.2MB single file), making it unmeasurable by the audit and overflow check (empty DOM dump). Decide: keep embed-resources or drop it so QA tooling can measure the deck.
- **Stray .pptx files at repo root:** the merge brought `Affiliation Networks .pptx` and `Centrality.pptx`. Undecided whether to delete, gitignore, or keep.
- **Permanent slide-QA scripts (repo root, promoted from scratch 2026-10-20):** `check_overflow.py` (per-slide vertical overflow; `--all`, `--dump`, `--warn-only`, accepts .qmd or .html, exits 1 on overflow) and `dump_slide.py <html> <slide-id...|--overflow|--all>` (per-element geometry sorted by bottom edge — the diagnostic for WHICH element pushes a slide over). Both share `audit_slide_sizes.py`'s injection guarantees and add: isolated `--user-data-dir` per launch, 4-attempt retry, POST transport for payloads (GET query strings break on big dumps — http.server request-line limit), UTF-8-safe stdout, and `what-are-networks` auto-skip.
- **Headless Chrome for QA (portable facts):** all three QA scripts auto-prefer `chrome-headless-shell` and honor `CHROME_BIN`; install it OUTSIDE the repo (a first attempt committed 272 MB of it and the "pusho" commit had to be amended — see the Large tracked media note above; it is `chrome-headless-shell/`-ignored in .gitignore). Install via `npx -y @puppeteer/browsers@2.4.1 install chrome-headless-shell@stable`. Machine-specific binary locations and launch quirks live in user memory.
- **Injected-instrumentation pitfall (cost hours on 2026-10-20):** an injected `<script>...</script>` block MUST include its closing `</script>` — with it missing, everything after injection becomes JS text, the parser hits a syntax error, and NOTHING runs (no payload, no error, deck-dependent-looking failures). Handwritten probes that "worked" were ones whose harness wrapped the JS in its own `<script>` tags — the asymmetry masqueraded as a content bug for a long time.
