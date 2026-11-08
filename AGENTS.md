# Social Networks Textbook Agent Memory

This file holds durable rules and workflows only. Dated history (QA session narratives, deck fix histories, resolved open items, incident details) lives in `INCIDENT_LOG.md`. Read it on demand only.

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
- `homeworks/`: Course homework assignments (`homework{1..9}.qmd`). **Legacy location:** the primary homework sources now live in the sibling repo `../SOCIOL 111/homeworks/`; this directory is a fallback that the Canvas sync script reads only if the sibling copy is absent. Rendered locally using `./render_homeworks.sh` and synced directly to UCLA Bruin Learn (Canvas LMS). Homeworks are explicitly excluded from public web publishing.
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
| `slides/ego-collect.qmd` | Collecting Ego-Network Data |
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
- `quarto render`; only chapters under `book: chapters:` render, to `_sites/`.

### 2. Homework Authoring & Canvas LMS Sync
1. **Edit:** `homework{1..9}.qmd` in the sibling repo `../SOCIOL 111/homeworks/` (primary source). This repo's `homeworks/` is the legacy fallback (or use `--remote`; per-machine checkout status lives in user memory).
2. **Render** from this repo: `./render_homeworks.sh 1` (one) or `./render_homeworks.sh` (all 1–9) → `homeworks/homework{i}.html` + `homeworks/homework{i}_files/figure-html/`.
3. **Sync** from `../SOCIOL 111` (folder name has a space): `python3 sync_homeworks_to_canvas.py --dry-run --hw 1`, then without `--dry-run`. Source resolution order: sibling `homeworks/` → `../networks-textbook` (or `NETWORKS_TEXTBOOK_DIR`) → GitHub; `--remote` forces GitHub.
4. **Privacy:** homeworks and answer keys must never reach `_sites/` or the public site. The `*-5562048*` suffix hack and `render_homeworks.ps1` are retired.

### 2b. Course Glue (two repos, one window)
Glue lives at the `ACADEMICS` level, outside both repos (`../networks-textbook` public/auto-deploys; `../SOCIOL 111` private):
- **`../course`** (bash): `course status` (git status both repos); `course push "message"` (commits **tracked changes only** — untracked files are listed, never auto-added — then pushes each changed repo); `course hw N [live]` (render homework N, then Canvas-sync; dry-run unless `live`).
- **`../SOCIOL-111.code-workspace`**: Positron multi-root workspace ("textbook (public)" / "SOCIOL 111 (private)").

### 3. CI/CD (`.github/workflows/publish.yml`, on push to `main`, `ubuntu-latest`)
1. Pre-render validation: `python check_book_refs.py` (cross-refs in active chapters) and `python check_book_citations.py` (bib keys exist in `networks.bib`); both fail the build.
2. R deps via `r-lib/actions/setup-r@v2` with P3M binaries (`use-public-rspm: true`).
3. Book build → `_sites/`. 4. Changed `slides/*.qmd` → `_sites/slides/`.
5. Slide size audit `python audit_slide_sizes.py --no-render` on changed decks — `continue-on-error: true` (decide whether to enforce with `false`).
6. Deploy `_sites/` to GitHub Pages.
- **Concurrency guard:** `concurrency: { group: gh-pages-deploy, cancel-in-progress: true }` — the peaceiris deploy pushes `gh-pages` non-forced, so two quick pushes to `main` used to race. Superseded runs show as **"cancelled", not "failure"** — expected.

### 4. Slide Deck Size Floor
**CSS floor** (end of `slides/ucla-theme.css`):
- `.reveal .math.display { font-size: max(1em, 34px) }` — display math never below the 34px base font.
- `.reveal .math-dense .math.display { font-size: max(1em, 20.8px) }` — inside an explicit dense wrapper `<div class="math-dense" style="font-size: NN%;">`, math follows the wrapper but never below 20.8px (72% of 28.9px prose). **Any deliberate font-size shrink div must carry `class="math-dense"`**, or the 34px floor inflates its equations and re-overflows the slide.
- **Table floor:** kableExtra writes `font-size` inline on `<table>`, so floor the cells in em: `.reveal td, .reveal th { font-size: max(1em, 18px) }` (≥18px authored tables untouched). `.table-dense` wrapper floors at 16px (secondary-table convention).
- **scroll_box fixes:** `overflow-x: auto !important` on `div[style*="overflow-x: scroll"]` (kableExtra hardcodes `scroll`, showing a scrollbar even when the table fits) and `box-sizing: border-box !important` on the bordered 100%-width box (its 1px border otherwise overflows 2px). Only centrality currently uses `scroll_box`.

**Audit** (`audit_slide_sizes.py`, repo root) renders in headless Chrome (waits for MathJax + images), measures on-canvas sizes, flags: display math below 34px (20.8px in `.math-dense`), wider than 1024px usable width, or never typeset; figures below 75% of **intended** size (knitr `width` attr = fig-width in CSS px; rasters are 2× retina — never compare displayed px to raw raster) or authored below 3.3in; table cell text below 18px (16px in `.table-dense`; nested tables skipped).
- Usage: `python audit_slide_sizes.py slides/<deck>.qmd` (auto-renders stale decks), `--no-render`, `--dump PATH` (raw JSON), `--warn-only`. Exit 1 on violations. Needs headless Chrome (`CHROME_BIN` overrides).
- Measurement essentials: divide by `Reveal.getScale()` and launch with `--force-device-scale-factor=1` (headless DPR ≠ 1 shrinks everything ~26%); measure `span.MathJax` inside `MathJax_Display`, not the full-width div; write the instrumented HTML copy **next to the deck** (relative `*_files/` resources break from a temp dir).
- `--dump` `w` for math inside a wrapper is measured at the WRAPPER's font size, not at 34px — don't rescale it to diagnose a wrapper as unnecessary.
- **Flake:** the auto-render pass can report false "display math never typeset" (empty latex) when MathJax hasn't finished — re-run with `--no-render` on the fresh HTML; both runs must agree.
- **Always re-render before auditing** a fresh checkout: `slides/*.html` are untracked build artifacts, and stale HTML gives false alarms. Delete orphaned HTML for retired decks.
- **what-are-networks is unmeasurable** (`embed-resources: true`, 8.2MB; headless Chrome returns an empty DOM); QA scripts skip it.

**Phantom-slide pitfall:** a `---` directly under a `$$...$$` line with no blank line makes pandoc parse the equation as a setext heading (own auto-titled slide, heading size). Always put a blank line between display math (or a raw `</div>`) and `---`.

**Static image retrofit:** replace `width="85%"`/`height="420px"` with an explicit `width="NNNpx"` equal to the real displayed width (from `--dump`, rounded at or below). The audit otherwise falls back to the full natural raster. For knitr figures, set `fig-width`/`fig-height` proportional to the real displayed size (a 12in strip displayed at 844px fails at 73%; at 8.8in it renders ~1:1).

### 5. Slide Overflow QA
No slide may scroll vertically; split rather than shrink fonts aggressively.

**Minimum visibility floors** (never shrink below; split, rebalance columns, or move content into the column with slack):
- Figures (ggraph/ggplot): square figures ≥ **3.5in** (keep w = h so layouts don't distort); 3.3in tolerable only in a narrow (~30%) side column; wide multi-panel strips ≥ **2.9in** tall. Node points ≥ 15, node labels ≥ 7; arrowheads ≥ 3.5mm with `end_cap` ≥ 6mm (small open arrowheads read as undirected).
- kable tables: `font_size` ≥ **18** (20 preferred for primary worked-example matrices); one-off 16 only for secondary tables in narrow columns. Helper defaults ARE the floor — never pass sub-18 sizes, so source and render agree.
- If an exhibit needs squinting, the slide is overfull. A referenced worked-example graph/matrix must be visible on the same slide.

**QA scripts (repo root):**
- `check_overflow.py` — per-slide vertical overflow; `--all`, `--dump`, `--warn-only`; accepts .qmd or .html; exits 1 on overflow. Forces `section{display:block}` + `.fragment{visibility:visible}`, so it measures with all fragments shown.
- `dump_slide.py <html> <slide-id...|--overflow|--all>` — per-element geometry sorted by bottom edge; finds WHICH element pushes a slide over.
- Both share the audit's injection guarantees plus: isolated `--user-data-dir` per launch, 4-attempt retry, POST transport for payloads (GET query strings hit the http.server request-line limit), UTF-8-safe stdout, `what-are-networks` auto-skip.
- On this machine always `export CHROME_BIN=~/.posit-assistant/tools/chrome-headless-shell/linux-156.0.8078.47/chrome-headless-shell-linux64/chrome-headless-shell` first (auto-detection fails). Install chrome-headless-shell OUTSIDE the repo (`chrome-headless-shell/` is gitignored): `npx -y @puppeteer/browsers@2.4.1 install chrome-headless-shell@stable`. (pin 2.4.1: the latest installer needs Node ≥ 20). For custom probes, `npm i puppeteer-core` (v25 is ESM-only: use dynamic `import()`).

**Measurement rules (for any custom probe):**
- `scrollable: true` makes overflowing slides scroll; measure, don't eyeball. A slide scrolls iff `scrollHeight > clientHeight` and computed `overflow-y` is `auto`/`scroll`; these ignore Reveal's transform scale. `# Part N` dividers report small deltas but are `overflow-y: visible` — ignore. Quarto's `scrollable` class is only a heuristic.
- Drive slides with `Reveal.slide(h, v, f)` (decks nest `##` slides inside `#` sections); wait for `Reveal.isReady()`, `MathJax.startup.promise`, `document.fonts.ready`, every `<img>` loaded (Quarto emits lazy `data-src` images that report height 0), and poll `scrollHeight` until stable (~250ms).
- **Never advance fragments with a blind `Reveal.next()` loop** — once fragments run out it moves to the next slide, so measurements land on the wrong slide. Raise the fragment index via `Reveal.slide(h, v, f)` and assert you stayed on the target slide.
- Check table (or `scroll_box` wrapper) bottom edges against the slide bottom; QA checks vertical overflow only — check horizontal spills (display math overflowing its column onto a neighbor, long single-span inline math) by eye. Inline `$...$` spans wrap only BETWEEN spans; split long ones into comma-separated spans. Dense-wrap equations that near their column width.
- An injected `<script>` block MUST include its closing `</script>`, or nothing runs and failures look deck-dependent.
- **Fragment screenshots:** decks with `incremental: true` render bullets as hidden `li.fragment`; plain screenshots show only titles. Write a temp HTML copy next to the deck, inject `<style>.fragment{visibility:visible !important;opacity:1 !important;transform:none !important}</style>` before `</head>`, screenshot, delete the copy. Screenshot via chrome-headless-shell with id-hash URLs (`#/slide-id`; numeric hashes unreliable) and `--virtual-time-budget=15000`.

**Quarto/Pandoc pitfalls:**
1. A raw `<div style=...>` must open and close **within** one `:::` fenced div. If `</div>` lands after the parent `:::` closes, pandoc swallows the rest of the deck (render still says "Output created", with a `Div ... unclosed` WARNING — always check the log). In columns, close the raw `<div>` BEFORE the column's `:::`.
2. `::: {.column width="60%" style="font-size: 85%;"}` drops the custom style ("Ignoring duplicate attribute"); use `::: {.column style="width: 60%; font-size: 85%;"}`.
3. When splitting a `::::` columns block mid-slide, the first half needs its own `::::` closer before the `---`.

**Layout facts and fixes:**
- `ucla-theme.css`: 34px base font; `p, li { font-size: 0.85em }` does NOT apply to tables, so tables (especially text tables in narrow columns, one word per line) are usually the tallest element.
- Fix order: split the slide; move bullets into the column with slack; drop subheadings that duplicate the title; wrap a column in `<div style="font-size: 80-90%">` (72% floor); shrink square figures with w = h.
- Costs to budget: each MathJax display line ~80–100px (merge step-by-step calcs into ONE display line, put the takeaway in a bullet; convert mid-sentence `$$` to inline `$`); a knitr figure cell renders ~35px taller than fig-height×96; an empty `. . .` marker renders as a ~35px `<p>` + margins; a 55% column wraps at ~44 chars/line. Never stack intro bullets above a columns block holding a figure + two matrices.
- Small overflows (+1 to +10px): trim ONE wrap line, shrink a figure ~0.1in, or drop an empty `. . .` marker — don't restructure.
- Tall images: use a raw block `<img src="../images/x.jpg" width="320" style="display:block; margin: 0 auto;">` inside the column to avoid the Quarto figure/`p` wrapper (~57px). Negative-margin wrapper divs don't work in flex columns.
- Six-term trace equations (~1030–1076px at 34px) can never fit 1024px: wrap in `<div class="math-dense" style="font-size: 100%">` (renders at 28.9px prose size) and keep the wrappers. Put long calculations on a full-width line BELOW the columns block.
- Circle layouts: keep the `coord_cartesian` xlim:ylim span ratio equal to the figure w:h ratio, or circles render as ellipses. Prefer side-by-side columns over a full-width centered square figure. Drop edge-width legends (`guide = "none"`) that eat panel width.
- Wide figures in narrow columns: shrink the ggsave canvas (e.g., 6.6→4.0in) to scale in-figure text up. Strip internal titles/subtitles from figures; slide text carries them.

### 6. Deck Helper Conventions
- **Persistent examples:** every slide discussing the worked example keeps it visible in a side column. Pin layouts (`create_layout(gr, "stress")` coords, or fixed circular coords, passed via `layout = "manual"`) so a graph looks identical on every slide; FR layouts cram the 19-node graph. Drop graph-legend bullets ("Red = C; green = friends").
- Highlight colors: light red `#F5B7B1` = active/left-matrix row; light blue `#AED6F1` = right-matrix column; green `#ABEBC6` / forestgreen = focal "answer" node; tan = others/intermediates.
- **centrality.qmd:** `kbl2(df, font = 18, hl)` splits node/score tables into side-by-side halves; `hl` does CELL-level highlight via `cell_spec()` + `escape = FALSE` (NOT `row_spec`, which shades both halves); uses `row.names = FALSE` (named vectors → duplicate rowname column). Matrix kbl calls (M19, dw8, dd8, dmat19) keep rownames. `g8()`/`g19()` take `hl` (red) and `hl2` (forestgreen). `k5 <- make_full_graph(5)` in setup.
- **matrix-multiplication.qmd:** `g6(catmap, ...)` (6-node party graph; red/blue focus, green shared friends, tan others), `kb6(m, font = 18)`; traced-cell slides keep FULL input matrices as MathJax `pmatrix` with the active row/column `\color`-highlighted (kable can't fit a side column), calculation full-width below. Directed example: matrix `DIR`, `gd()` helper (3.5mm closed arrowheads, end_cap 6mm, pentagon `l_coords_5dir`). `CP2 <- P %*% P` in setup.
- **matrix-advanced.qmd:** `reach_kbl(filled, active)` (5×5 reachability build, `?` unfilled, diagonal `--`, font 20), `weak_reach_kbl()` (from `distances(gr_weak, mode="out")`), `overlap_kbl(highlight = list(c("X","Y")))` (overlap = (A²)ᵢⱼ / (kᵢ + kⱼ − (A²)ᵢⱼ)), `plot_pair_flavor(nodes, edges, highlight, recip)`, `plot_neighbors_highlight`. Directed distance graph uses `layout_coords_5` (same digraph as Part 1); the undirected layout is exclusive to the undirected graph.
- **affiliation-networks.qmd:** `aff_kbl(filled, active, font = 18)` row-by-row build with `row_spec` highlight via `match()`.
- **structural-holes.qmd:** `obstfeld_motif()` (knitr 3.3 × 1.6in), `p_env_overlap/refresh/topics` cards (3.3 × 1.45in).
- **ego-collect.qmd:** `draw_net()` with fixed coordinates for alters a–g; illustrative tables `pg_A`/`pg_B`, `rg_C`/`rg_D`; all example responses labeled invented. Restoring the source deck's visual-scale figures would require a citation.
- **kable pitfalls:** `knitr::kable` silently DROPS sequential integer rownames (1:n), so `column_spec(n+1)` goes out of bounds and fails the render — use an explicit label column (LETTERS rownames are kept). Apply `column_spec` BEFORE `row_spec` so the row color wins the intersection. `match()` on empty `active` → guard with `length(ai) && !is.na(ai)`.
- **ggplot pitfalls:** `annotate()` ignores `nudge_x` (bake offsets into x); `scale_linewidth_identity` fails on character values (use two `geom_segment` layers); use compact P1/P2 tags above nodes to avoid label collisions.

### 7. Bruin Learn (Canvas) API
Credentials: `CANVAS_API_TOKEN`, `CANVAS_URL` in `~/.Renviron` (strict `KEY=value` lines — no spaces around `=`, no quotes — or the sync script silently misses them). Course ID `238980`. Canonical Bruin Learn docs: `../SOCIOL 111/AGENTS.md` (section G for announcements).
- **Announcements:** `POST /api/v1/courses/238980/discussion_topics`, **form-encoded** (`--data-urlencode`): `title`, `message` (HTML), `is_announcement=true`, `published=true`. Verify the response's `is_announcement: true`; the documented `announcement` param is silently ignored (fallback = delete and recreate).
- **Wrong routes:** `POST .../announcements` and `POST`/`GET .../discussions` return a 404 HTML page — a route symptom, not auth/CSRF.
- `POST /modules/:id/reorder` is CSRF-protected and always fails with a Bearer token; reposition with `PUT /modules/:module_id/items/:item_id` + `{"module_item": {"position": N}}`.
- New module items default to `published: false`; publish via `PUT .../items/:item_id` `{"module_item": {"published": true}}`.
- GET on assignments and module items works — confirm dates/order from the live API before telling students.
- **Swap a slide link:** slide items are `ExternalUrl`; find IDs via `GET /api/v1/courses/238980/modules?include[]=items`, then `PUT .../modules/:module_id/items/:item_id` with form `module_item[external_url]=<url>`; published state is preserved; confirm with GET. Mapping: item 8300732 "Slides: Ego Network Metrics" → `https://olizardo.github.io/networks-textbook/slides/ego-metrics`; item 8300733 "Slides: Collecting Ego Network Data" (module 1938344) → `.../slides/ego-collect`.
- **Submission checks from R:** `httr2` is NOT in the textbook renv; use base R `download.file(url, out, headers = c(Authorization = paste('Bearer', token)))` + `jsonlite::fromJSON()`. `system2('curl', ...)` splits the auth header unless each arg is `shQuote`d.

## AI Agent Guidelines
- **Adding chapters:** follow the naming convention and add the file to `_quarto.yml` under `book: chapters:`.
- **LaTeX matrix rows:** inside `$$\begin{pmatrix}...\end{pmatrix}$$` separate rows with exactly `\\`; `\\\\` renders empty rows that double matrix height.
- **Slide figure sizing:** match chunk `fig-width` to the displayed column width (e.g., `fig-width: 3.5` for a ~263px half-column) so text renders ~1:1.
- **Canvas assignment links:** when a lesson ends a topic with a homework, add `::: {.callout-tip} ## Associated Assignment on Bruin Learn ... :::`.
- **Slide image references:** decks reference root images as `../images/<filename>`; `images/` is registered under `project.resources` in `_quarto.yml`.
- **R execution:** use `renv::restore(prompt = FALSE)` (the prompt doesn't render in the Positron console and looks like a hang).
- **Context:** educational resource — keep explanations clear and accessible to students.
- **Content accuracy:** verify every quoted number in a deck against the deck's own setup objects (graphs are generated from matrices, so graph↔matrix agreement holds by construction). Don't invent product features or real-world mechanisms to motivate a network concept.
- **"Missing image" reports:** before debugging source, verify with a headless screenshot + `curl` of the live URL; a browser tab older than the image file needs a hard reload.
- **Figure text clipping:** white node labels wider than their circle get cut at the edge ("Alter 1" → "lter"). Label nodes with short ids and put longer text beside the node; add `plot.margin` so titles/nodes don't clip. Use `coord_cartesian(clip = "off")`.
- **Bitmap QA gap:** the QA scripts measure layout only; view every regenerated PNG (read tool) before calling a figure fixed.
- **Rounding in worked examples:** carry three decimals and compute final ratios from unrounded intermediates (H/H_max = 0.611/0.667 = 0.92, not 0.61/0.67 = 91%).
- **Figure provenance (rule):** every static PNG referenced in `slides/*.qmd` MUST have a committed generating script (`images/make_<name>.R`, run from repo root). Exempt: third-party/photographic assets (`aig-interlocks-2004.jpg`, `body.jpg`, `brain.jpg`, `got.png`, `usairport.png`). Commit generating code alongside any redrawn PNG.
- **Schematic-figure captions:** stylized/schematic charts or networks get an italic caption saying they are not the study's data.
- **Bibliography keys:** use `burt92` (*Structural Holes*, 1992), not the old `burt95`.
- **Git hygiene:** never blanket `git add .` (large binaries slip in; GitHub rejects files >100 MB).

## Open Items
- **Push pending — Fischer slides in `slides/ego-collect.qmd`** (two slides after "Famous Name Generators", from repo-root `fiischer.pdf`, McCallister & Fischer 1978). QA-clean, not pushed; pushing deploys them (Canvas item 8300733 already points at the deck).
- **structural-holes floor fixes** (`obstfeld_motif` 3.3×1.6, `p_env_*` 3.3×1.45) may still be uncommitted — check `git status`. The user's new figure content (sawtooth, pies, predictor bars, motif cards) has not been screenshot-reviewed. Consider pairing the Obstfeld open and closed matrices in one table.
- **Stale `images/ego-metrics-ei.png`:** prints H/H_max = 91% (rounded inputs); slides say 0.92. Regenerate (no source script).
- **`images/hofstra-minority-paradox.png`:** title "Core vs. Extended" over a network-size axis is wrong (captioned as stylized; no source script).
- **Ego-metrics deck:** slide 2 says "E-I Homophily Index" vs. "Homogeneity (E-I)" in summary/figure; the deck's 6-alter worked example differs from chapter 26's 7-alter example.
- **Ego-homogeneity deck:** "Majors & activities" (foci figure) vs. "course areas" (text); remaining overclaims ("automatically," "mathematically forced," "mathematically dilutes"); add a bridge linking McPherson's baseline/inbreeding to choice/induced homophily; "Positive Affiliation Contagion" vs. "Indirect Contagion" naming.
- **Quiz 3 / ego-homogeneity scope:** Quiz 3 Lesson 11 slots (15–18) draw only from slides up to "Feld's Rule: How Segregated Foci Drive Homogeneity" (~line 289); don't extend items past it without re-checking lecture progress. Quiz 3 grade release Wed Nov 11 via `release_quiz_grades.py --quiz 3` (SOCIOL 111 repo).
- **Citations to verify:** `burt05`, `obstfeld05`, `krackhardt88`, `simmel08`, `simmel50` (added from memory); Feld (1982) attribution for "Feld's rule"; Hofstra sample figures (N = 2,810, ~1.1 million ties).
- **Remaining ungenerated statics:** `ego-metrics-ei.png` and `hofstra-minority-paradox.png` still lack generating scripts, in violation of the provenance rule.
- **Canvas:** item 8300738 "Slides: Diffusion of Innovations" (module 1938348, Week 10) still points to Google Slides; swap once a deployed deck exists.
- **`ppt_slides/Collecting Ego Network Data.pptx`** is untracked (not committed).
- **what-are-networks `embed-resources: true`:** decide whether to keep it or drop it so QA tooling can measure the deck.
- **Stray root `.pptx`** (`Affiliation Networks .pptx`, `Centrality.pptx`): delete, gitignore, or keep? Also a stray `_sites/slides/graph-connectivity.qmd` from a retired deck.
- **Repo weight (~402 MB tracked):** `_freeze/` 122 MB and `ppt_slides/` 101 MB are the big targets if weight ever matters; also `WandF.pdf` 15 MB, `homeworks/` 10 MB.
