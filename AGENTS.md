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
- `homeworks/`: legacy fallback copies of homework sources. Primary sources live in `../SOCIOL 111/homeworks/`. Homeworks and answer keys are excluded from public publishing.
- `scraps/`: Drafts, retired chapters, and working fragments excluded from the book build.

## Chapter Inventory
Chapter order lives in `_quarto.yml` (`book: chapters:`); titles come from each file's first `#` heading or YAML `title:`. Do not maintain a separate table here.

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
| `slides/diffusion-of-innovations.qmd` | Diffusion of Innovations (draft; not yet pushed) |

## Core Workflows

### 1. Rendering the Textbook
- `quarto render`; only chapters under `book: chapters:` render, to `_sites/`.

### 2. Homework and Canvas Work
Homework authoring, Canvas sync, quizzes, and course glue are owned by `../SOCIOL 111/AGENTS.md`. Rule for this repo: homeworks and answer keys never reach `_sites/` or the public site.

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
- Highlight colors: light red `#F5B7B1` = active/left-matrix row; light blue `#AED6F1` = right-matrix column; green `#ABEBC6` / forestgreen = focal answer node; tan = others and intermediates.
- Per-deck helper functions are documented in each deck's setup chunk, not here.
- **kable pitfalls:** `knitr::kable` silently DROPS sequential integer rownames (1:n), so `column_spec(n+1)` goes out of bounds and fails the render; use an explicit label column (LETTERS rownames are kept). Apply `column_spec` BEFORE `row_spec` so the row color wins the intersection. `match()` on empty `active` → guard with `length(ai) && !is.na(ai)`.
- **ggplot pitfalls:** `annotate()` ignores `nudge_x` (bake offsets into x); `scale_linewidth_identity` fails on character values (use two `geom_segment` layers); use compact P1/P2 tags above nodes to avoid label collisions.

### 7. Bruin Learn (Canvas)
Canvas API rules live in `../SOCIOL 111/AGENTS.md`. The one procedure used from this repo is the slide-link swap:
- Slide items are `ExternalUrl`. Find IDs via `GET /api/v1/courses/238980/modules?include[]=items`, then `PUT .../modules/:module_id/items/:item_id` with form `module_item[external_url]=<url>`. Published state is preserved; confirm with GET.
- Canvas lesson pages that embed slides use an `iframe` to the GitHub Pages deck URL plus an "Open slides" link. Swap both when changing a deck.

## AI Agent Guidelines
- **Adding chapters:** follow the naming convention and add the file to `_quarto.yml` under `book: chapters:`.
- **LaTeX matrix rows:** inside `$$\begin{pmatrix}...\end{pmatrix}$$` separate rows with exactly `\\`; `\\\\` renders empty rows that double matrix height.
- **Slide figure sizing:** match chunk `fig-width` to the displayed column width (e.g., `fig-width: 3.5` for a ~263px half-column) so text renders ~1:1.
- **No homework or Canvas assignment links in the textbook:** Canvas assignment IDs and due dates change each term, so do not add "Associated Assignment" callouts or links to homework pages.
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
- **Measured-midpoint schematics:** S-curve schematics (`images/make_diffusion_schematic.R`) anchor only each curve's 50% midpoint to a cited measured value. Curve steepness is illustrative and must be labeled as such. Each series' denominator goes in its legend label. A series with no measured 50% point is left out.
- **Census sourcing:** prefer primary Census tables. When a value comes from a secondary reproduction or a web summary, flag it in the sources table rather than presenting it as Census data.
- **Bibliography keys:** use `burt92` (*Structural Holes*, 1992), not the old `burt95`.
- **Git hygiene:** never blanket `git add .` (large binaries slip in; GitHub rejects files >100 MB).

## Open Items
- **Diffusion Canvas swap:** Lesson 18 page and module item 8300738 still embed Google Slides. Swap both to `slides/diffusion-of-innovations` once GitHub Pages serves the deck.
- **Diffusion chapter render:** chapter 46 has an opening section (Figure 1, Table 1). Only that chapter was rendered; run a full book render before the site is updated.
- **Diffusion sources:** the automobile (1948) and radio (1932) midpoints rest on secondary summaries. Electricity and telephone values come from Census reproductions, not the original PDFs. Verify before publication.
- **Ego-metrics deck:** slide 2 says "E-I Homophily Index"; the summary says "Homogeneity (E-I)" (around line 184).
- **Ego-homogeneity deck:** "Majors & activities" (figure label, line ~92) vs. "course areas" (line ~328); overclaims at lines ~242 ("automatically"), ~390 ("mathematically forced"), and ~490 ("mathematically dilutes"); "Positive Affiliation Contagion" (line ~365) vs. the "Indirect Contagion" heading (line ~360).
- **Ungenerated statics:** `images/ego-metrics-ei.png` (prints H/H_max = 91%; slides say 0.92) and `images/hofstra-minority-paradox.png` (wrong axis title) have no generating script, which violates the provenance rule.
- **Citations to verify:** `burt05`, `obstfeld05`, `krackhardt88`, `simmel08`, `simmel50` (added from memory); Feld (1982) attribution; Hofstra sample figures (N = 2,810, ~1.1 million ties).
- **what-are-networks:** `embed-resources: true` (line 13) makes the deck unmeasurable by the audit. Decide whether to drop it.
- **Stray root files:** `Affiliation Networks .pptx` and `Centrality.pptx` are untracked clutter. Delete, gitignore, or keep.
- **Glossary and navbar homework references:** `glossary.qmd` has about 51 plain-text "Homework N" references, and `_quarto.yml` links the navbar to Bruin Learn Assignments and Syllabus pages. Decide whether to remove both.
- **Repo weight:** `_freeze/`, `ppt_slides/`, `WandF.pdf`, and `homeworks/` are the large tracked items if weight matters.
