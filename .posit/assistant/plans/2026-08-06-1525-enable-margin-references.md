# Plan: Enable Margin References and Citations in Quarto Configuration

This plan outlines the updates required to enable margin references and footnotes across the entire textbook.

## Proposed Changes

We will update the `_quarto.yml` configuration file under the HTML format settings to include:
1. `citation-location: margin` - This places bibliography references (citations) in the margin.
2. `reference-location: margin` - This places footnotes in the margin, maintaining visual consistency.

## Steps to Execute

1. **Modify `_quarto.yml`:**
   - Locate the `format: html:` block.
   - Add `citation-location: margin` and `reference-location: margin`.

2. **Verify changes:**
   - Read `_quarto.yml` to confirm correct indentation and formatting.
