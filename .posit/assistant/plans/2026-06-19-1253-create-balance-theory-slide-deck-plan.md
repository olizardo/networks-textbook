# Plan: Resolve Netlify/GH-Pages Slides Deployment Issue

The user reports that slides no longer show up under `https://networks-textbook.netlify.app/slides/slide-name` on Netlify, even though Netlify is configured to deploy directly from the `gh-pages` branch.

An investigation of the repository and the deployment history reveals:
1. The `gh-pages` branch is updated via local manual builds (the last commits are authored by the user with the commit message `"Built site for gh-pages"`, which is the default for `quarto publish gh-pages`).
2. When Quarto renders the book locally, it only processes the book chapters specified in `_quarto.yml` and outputs them to `_sites/`. It does **not** compile or copy the `slides/` directory because `slides/` is not a book chapter.
3. As a result, when publishing from the local machine via `quarto publish gh-pages`, the `slides/` folder is left out of the deployment to `gh-pages`.

---

## The Solution

We can configure Quarto to treat the `slides/` directory as a **project resource**. This tells Quarto to automatically copy the entire compiled `slides/` folder (including the HTML slide decks, CSS theme files, and support figure folders) into the output `_sites/slides/` directory whenever the book is rendered or published.

### Step 1: Update `_quarto.yml`
We will add `slides/` to the `resources:` list under `project:` in `_quarto.yml`:
```yaml
project:
  type: book
  output-dir: _sites
  resources:
    - .nojekyll
    - slides/
```

### Step 2: Push Local Changes
Since the local `main` branch is currently ahead of `origin/main` by several commits, once the files are saved, the local commits and the new slide decks should be pushed to GitHub:
```bash
git push origin main
```
This will trigger the GitHub Actions workflow to publish the site automatically.

### Step 3: Local Publishing fallback
Alternatively, if the user publishes manually from their machine, they can now simply run:
```bash
quarto render slides/
quarto publish gh-pages --no-render
```
Because `slides/` is listed in the project resources, the local `quarto publish` command will now **automatically bundle and deploy** the slides onto the `gh-pages` branch, serving them flawlessly on Netlify!
