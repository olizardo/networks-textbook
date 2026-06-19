# Plan: Create "Chains of Affection" Sexual Networks & Local Norms Slide Deck

## Goal
Create a comprehensive, high-pedagogy Quarto (`.qmd`) slide deck for a new unit in the social networks class. The unit will discuss how sexual and romantic networks act as the "perfect laboratory" to study how micro-level social rules (local norms) generate macro-level network structures. It integrates Bearman's classic study, McMillan et al.'s friendship peer code, fictional TV networks (Glee, Grey's Anatomy), sexual orientation variations (The L Word), and celebrity rumor networks (from whosdatedwho.com).

## Target Slide File
We will create a new slide deck: `slides/chains-of-affection.qmd`.

## Detailed Slide Deck Outline & Layouts

### 1. Title & Introduction (The Micro-Macro Link)
*   **Slide 1: Title Slide**: "Chains of Affection: How Local Norms Shape Romantic and Sexual Networks".
*   **Slide 2: The Perfect Laboratory**: Introduces why sexual/romantic networks are ideal for study (finite boundaries, highly consequential for epidemics, but actors have zero global awareness—they only navigate immediate local choices).
*   **Slide 3: Micro-Rules, Global Structures**: Focuses on the central question: How do unwritten, local rules scale up to large-scale network topologies? Bolds key concepts like **emergence**, **micro-level proscriptions**, and **macro-level networks**.

### 2. Peter Bearman's Landmark Study (Jefferson High)
*   **Slide 4: The Spanning Tree Mystery**: Peter Bearman, James Moody, and Katherine Stovel's (2004) *AJS* study of Jefferson High. Bolds **spanning tree** and **chain-like branches**.
*   **Slide 5: The Absence of Cycles**: Explains that standard network models predict highly clustered, dense pockets. Jefferson High, however, has a complete absence of short cycles (especially 4-cycles). 
*   **Slide 6: The "Seconds Partnership" Taboo**: Explains Bearman's proposed rule: "A person does not date their ex's current partner's ex." Displays a clean diagram of a 4-cycle loop (A-B-C-D) and details why completing this loop causes a public loss of status ("taking seconds").

### 3. McMillan et al. & Peer Context (Girl Code / Bro Code)
*   **Slide 7: Critique of the Classic Norm**: Cassie McMillan, Derek Kreager, and René Veenstra (2022) "Keeping to the Code". Bolds **face validity** and **peer context**. Explains that high schoolers don't think in complex ex-partner chains.
*   **Slide 8: Girl Code and Bro Code**: Introduces the alternative, peer-grounded rule: "Do not date a friend's previous partner" ("no seconds" norm). Bolds **relationship dissolution** and **friendship loyalty**.
*   **Slide 9: Visualizing peer-dating rules**: Illustrates how the same-sex friendship code naturally blocks the closure of 4-cycles, generating the exact same **spanning tree** macro-structure but with vastly higher social realism.

### 4. Reality vs. Fiction (The TV Cases of Glee and Grey's Anatomy)
*   **Slide 10: Fictional Network Overlaps**: Jimi Adams (2015) on *Glee* (seasons 1-2) and Marcum et al. (2016) on *Grey's Anatomy* (GAN, seasons 1-6).
*   **Slide 11: Plot Tensions and 4-Cycles**: Explains that television shows have way more 4-cycles (42% in Glee, 12 in GAN) than real high schools because writers violate norms to create **dramatic tension**.
*   **Slide 12: Art Imitates Taboo**: Shows that once you control for cast size and activity via ERGMs, fictional characters *still* show a statistically significant aversion to 4-cycles. Fictional writing implicitly conforms to societal taboos!

### 5. Same-Sex Constraints (The L Word Case)
*   **Slide 13: Adult Same-Sex Hook-ups**: Marcum, Lin, and Koehly (2016) comparing Grey's Anatomy with Showtime's *The L Word* (predominately lesbian same-sex network).
*   **Slide 14: Structural Market Constraints**: Shows that *The L Word* has **no aversion** to 4-cycles. Bolds **structural constraints** and **market size**. In small, same-sex dating markets, cycle avoidance is suspended out of necessity; "love triangles" are normalized.

### 6. Rumors vs. Reality (Celebrity Networks & WhosDatedWho)
*   **Slide 15: Celebrity Networks**: Carmella Nicole Stoddard's (2024) UCLA dissertation using whosdatedwho.com (109,626 nodes, 88,746 edges).
*   **Slide 16: Confirmed vs. Rumored Ties**: Explains the difference between confirmed relationships and rumored ties. Bolds **gossip**, **rumors**, and **counter-normative behavior**.
*   **Slide 17: How Gossip Reveals Structure**: Details the finding that rumored ties **significantly increase short cycles (3-cycles and 4-cycles)** and bisexual nodes. Bolds **salaciousness** and **surveillant interest**. Gossip is a social filter that selectively targets and amplifies norm violations because they are interesting!

### 7. Class Discussion & Takeaways
*   **Slide 18: Summary of Micro-to-Macro Link**: Reviews the main rules.
*   **Slide 19: Epidemiological Consequences**: Contrasts spanning trees (extremely fragile to random interventions) with core models (highly resilient).
*   **Slide 20: Class Discussion Questions**: Prompts students on local norms and network structures.

## Verification Plans
1. Check that the `.qmd` slide deck compiles successfully with Quarto render.
2. Verify that there are no cropping issues on any ASCII art or ggraph plots (using explicit coordinate limits and `clip = "off"` on any included R code plots).
