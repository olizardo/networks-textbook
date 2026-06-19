# Plan: Complete Slide Deck on Balance Theory and Signed Graphs

This plan outlines the design and structure for a dedicated slide deck on **Balance Theory and Signed Graphs** in social network analysis. The content is synthesized directly from the textbook chapters (`lesson-theory-dyadic-balance.qmd`, `lesson-theory-triadic-balance.qmd`, `lesson-theory-structural-balance.qmd`, and `lesson-theory-valenced-interactions.qmd`) and slide files (`ppt_slides/Balance/Balance.pptx`).

The slide deck is structured into five distinct, logically ordered parts spanning **24 slides**, complete with **key concepts in bold**, slide objectives, and **interactive/visual diagrams** (represented as Mermaid charts) for almost every slide.

---

## Part 1: The Relational Basis of Valenced Networks & Dyadic Balance (Slides 1–5)

### Slide 1: Title & Overview
- **Title**: Balance Theory and Signed Graphs: The Local and Global Dynamics of Sentiment Networks
- **Core Concepts**: **Sentiment Networks**, **Valenced Ties**, **Structural Dynamics**
- **Content**:
  - Introduction to how social psychology and graph theory intersect to study positive and negative social interactions.
  - Overview of the slide deck: Dyadic Balance, Triadic Balance, Structural Balance, Clusterability, and Modern Extensions (Karma, Status, Solidarity).
- **Visual Aid**: A clean Mermaid diagram showing three nodes connected by positive (+) and negative (-) links.
  ```mermaid
  graph TD
    A((A)) -- "+" --> B((B))
    B -- "+" --> C((C))
    C -- "-" --> A
  ```

### Slide 2: Valenced Ties & Signed Graphs
- **Title**: The Anatomy of sentiment Networks
- **Core Concepts**: **Valenced Ties**, **Signed Graph**, **Sentiments**
- **Content**:
  - Definition of **valence**: ties have directionality and a specific positive (+) or negative (-) character (e.g., liking vs. hating, helping vs. bullying).
  - A **signed graph** features a set of vertices $V$ and two disjoint sets of edges: positive links $E^+$ and negative links $E^-$.
  - These graphs capture the emotional, attitudinal, or conflictual "states" in social networks.
- **Visual Aid**:
  ```mermaid
  graph LR
    A((Ego)) -- "+ (Liking/Helping)" --> B((Alter 1))
    A -- "- (Disliking/Conflict)" --> C((Alter 2))
    style B fill:#d4edda,stroke:#28a745,stroke-width:2px
    style C fill:#f8d7da,stroke:#dc3545,stroke-width:2px
  ```

### Slide 3: Dyadic Balance Theory
- **Title**: Fritz Heider's Dyadic Balance
- **Core Concepts**: **Fritz Heider (1946)**, **Symmetric Ties**, **Asymmetric Ties**, **Cognitive Consistency**
- **Content**:
  - Developed by social psychologist Fritz Heider to explain how different types of ties cohere within a single pair.
  - Distinction between **symmetric ties** (similarity, co-membership, shared attribute) and **asymmetric ties** (sentiment-based relations like liking or helping).
  - Heider's first proposition: Symmetric ties of similarity/proximity breed positive asymmetric ties ($aSb \implies aLb$).
  - Once formed, they lock into a **positive feedback loop** ($aLb \implies aSb$).
- **Visual Aid**:
  ```mermaid
  graph LR
    subgraph Similarity (Symmetric)
      A1((a)) ---|Same Class/Group| B1((b))
    end
    subgraph Sentiment (Asymmetric)
      A2((a)) -- "Liking (+)" --> B2((b))
    end
    Similarity --> Sentiment
  ```

### Slide 4: Multiplex Ties & Propinquity
- **Title**: Proximity, Similarity, and Multiplexity
- **Core Concepts**: **Multiplex Ties**, **Principle of Propinquity**, **The Acquaintance Process**
- **Content**:
  - Over time, individuals accumulate different types of ties, resulting in **multiplex ties** (anthropologists' term for "multistranded" ties).
  - **Principle of Propinquity** (Newcomb 1956): Sharing physical space or social categories automatically increases the likelihood of positive tie formation.
  - Similarities of any kind (e.g., same neighborhood, class, or work) breed liking, which then leads to advice, friendship, and support.
- **Visual Aid**: A multiplex representation where two nodes are connected by multiple overlapping layers.
  ```mermaid
  graph LR
    A((A)) ===|Symmetric Similarity (Co-workers)| B((B))
    A -.->|Asymmetric Sentiment (Liking)| B
    B -.->|Asymmetric Sentiment (Liking)| A
    A ==>|Symmetric Interaction (Lunch)| B
  ```

### Slide 5: Cognitive Consistency & Tension Resolution
- **Title**: Dyadic Balance and cognitive Tension
- **Core Concepts**: **Cognitive Consistency**, **Affective Tension**, **Signed Adjacency Matrix**
- **Content**:
  - Heider's second proposition: We actively avoid situations of conflicting ties (e.g., spending time with someone we dislike).
  - An arrangement of a symmetric tie and a negative asymmetric tie ($aSb \land aDb$) is **unbalanced**, producing **cognitive inconsistency** and **affective tension**.
  - Predictions for resolution: Either break the symmetric tie (distance oneself) or change the sentiment to positive (learn to like them).
  - Represented in a **signed adjacency matrix** with values in $\{+1, -1, 0\}$.
- **Visual Aid**:
  ```mermaid
  graph LR
    A((a)) ---|Symmetric S| B((b))
    A -- "Dislike (-)" --> B
    style A fill:#fdfd96,stroke:#f8e71c
    style B fill:#fdfd96,stroke:#f8e71c
    classDef unbalanced stroke:#dc3545,stroke-dasharray: 5 5;
  ```

---

## Part 2: Triadic Balance Theory (Slides 6–12)

### Slide 6: The P-O-Q Framework
- **Title**: Fritz Heider’s P-O-Q Triad
- **Core Concepts**: **Triadic Balance Theory**, **P-O-Q Triad**, **Directed, Signed Edges**
- **Content**:
  - Extends dyadic balance to three elements:
    - **Person (P)**: The focal individual from whose cognitive perspective the triad is analyzed.
    - **Other (O)**: A social alter towards whom P holds a sentiment.
    - **Third Party / Object (Q)**: A third actor, organization, or abstract cultural object/idea.
  - The relations are analyzed via **directed, signed edges** representing sentiments.
- **Visual Aid**:
  ```mermaid
  graph TD
    P((P - Focal)) -- "+ / -" --> O((O - Other))
    P -- "+ / -" --> Q((Q - Object))
    O -- "+ / -" --> Q
  ```

### Slide 7: The Sign Multiplication Rule
- **Title**: The Mathematics of Triadic Balance
- **Core Concepts**: **Sign Multiplication Rule**, **Harmonious Sentiments**, **Odd vs. Even Negative Links**
- **Content**:
  - A triad is **balanced** if the product of its three edge signs is positive:
    $$\text{Sign}(P, O) \times \text{Sign}(O, Q) \times \text{Sign}(P, Q) = +1$$
  - A simpler identification rule: A triad is balanced if it contains an **even number of negative links** (either exactly 0 or 2 negative links).
  - Balanced triads create zero cognitive tension and represent stable social arrangements.
- **Visual Aid**: A mathematical truth table showing the multiplication of signs.
  | Sign 1 | Sign 2 | Sign 3 | Product | State |
  | :---: | :---: | :---: | :---: | :---: |
  | $+$ | $+$ | $+$ | $+1$ | **Balanced** |
  | $-$ | $-$ | $+$ | $+1$ | **Balanced** |
  | $+$ | $-$ | $-$ | $+1$ | **Balanced** |
  | $+$ | $+$ | $-$ | $-1$ | **Unbalanced** |
  | $-$ | $-$ | $-$ | $-1$ | **Unbalanced** |

### Slide 8: Balanced Triads: The 4 Stable Configurations
- **Title**: "The Friends of My Friends"
- **Core Concepts**: **Balanced Triads**, **Friend of a Friend**, **Enemy of an Enemy**
- **Content**:
  1. **"A friend of a friend is a friend"** ($+ \times + \times + = +1$): Zero negative links. Standard positive cohesion.
  2. **"An enemy of an enemy is a friend"** ($- \times - \times + = +1$): Two negative links. Basis for alliances against a common rival.
  3. **"A friend of an enemy is an enemy"** ($- \times + \times - = +1$): Two negative links. Rejecting those associated with your rivals.
  4. **"An enemy of a friend is an enemy"** ($+ \times - \times - = +1$): Two negative links. Standing by your friend's dislikes (e.g., country alliances in war).
- **Visual Aid**: Four distinct mini-triads showing the sign patterns.
  ```mermaid
  graph LR
    subgraph Friend of Friend
      P1((P)) -- "+" --> O1((O))
      O1 -- "+" --> Q1((Q))
      P1 -- "+" --> Q1
    end
    subgraph Enemy of Enemy
      P2((P)) -- "-" --> O2((O))
      O2 -- "-" --> Q2((Q))
      P2 -- "+" --> Q2
    end
  ```

### Slide 9: Unbalanced Triads: The 4 Unstable Configurations
- **Title**: The Triads of Social Friction
- **Core Concepts**: **Unbalanced Triads**, **Odd Negative Links**, **Cognitive Inconsistency**
- **Content**:
  - An unbalanced triad has an **odd number of negative links** (1 or 3 negative links), leading to a product of $-1$.
  1. **"A friend of my friend is my enemy"** ($+ \times + \times - = -1$): Friend Alex hangs out with Jordan, whom you dislike.
  2. **"An enemy of a friend is a friend"** ($+ \times - \times + = -1$): Your partner dislikes Marvel movies, which you love.
  3. **"A friend of an enemy is a friend"** ($- \times + \times + = -1$): You and your archnemesis are attracted to the same person.
  4. **"An enemy of my enemy is my enemy"** ($- \times - \times - = -1$): You hate both the Yankees and the Red Sox; rooting is painful.
- **Visual Aid**:
  ```mermaid
  graph LR
    subgraph Friend of Friend is Enemy
      P1((P)) -- "+" --> O1((O))
      O1 -- "+" --> Q1((Q))
      P1 -- "-" --> Q1
    end
    subgraph All Enemies
      P2((P)) -- "-" --> O2((O))
      O2 -- "-" --> Q2((Q))
      P2 -- "-" --> Q2
    end
  ```

### Slide 10: Tension and Change
- **Title**: Psychological Drives and Social Transitions
- **Core Concepts**: **Tension Reduction**, **Structural Realignment**, **Equilibrium States**
- **Content**:
  - Unbalanced configurations produce cognitive discomfort, acting as a social-psychological **engine of network change**.
  - Balance theory predicts that unbalanced triads naturally transition towards balanced ones over time.
  - This resolution occurs when actors change the **sign or valence** of their directed links to restore equilibrium.
- **Visual Aid**: A transition flowchart showing an unbalanced state resolving into balance.
  ```mermaid
  graph LR
    A["Unbalanced (P+O, O+Q, P-Q) <br> [TENSION]"] -->|Option A: End friendship with O| B["Balanced (P-O, O+Q, P-Q)"]
    A -->|Option B: Make peace with Q| C["Balanced (P+O, O+Q, P+Q)"]
  ```

### Slide 11: Cross-Pressure
- **Title**: Caught Between Opposing Sentiments
- **Core Concepts**: **Cross-Pressure**, **Davis (1963)**, **Social Ambivalence**
- **Content**:
  - **Cross-pressure** occurs when a focal individual (P) is linked positively to multiple alters who hold diametrically opposed views on a subject/object (Q).
  - Predicted state: P develops an **ambivalent attitude** ($+/-$), combining both positive and negative sentiments, leading to psychological paralysis or moderation.
  - To resolve, P must either distance from one alter or convince the alters to reconcile.
- **Visual Aid**:
  ```mermaid
  graph TD
    P((P - Torn)) -- "+" --> O1((O1 - Likes Q))
    P -- "+" --> O2((O2 - Dislikes Q))
    O1 -- "+" --> Q((Q))
    O2 -- "-" --> Q
    P -.->|Ambivalence (?)| Q
  ```

### Slide 12: Cross-Pressure in Real-Life: Politics
- **Title**: partisan Polarization and Independent voters
- **Core Concepts**: **Cross-Pressure**, **Partisan Independence**, **Ambivalence**
- **Content**:
  - Classic application: political preferences.
  - Imagine P has a brother (O1) who loves the Democrats (+) and a sister (O2) who hates them (-).
  - As long as P maintains close positive relationships with both siblings, balance theory predicts P will experience **cross-pressure** regarding the Democrats (Q).
  - P's resulting attitude is highly likely to be **ambivalent** or moderate, driving them to identify as an "independent" rather than a strong partisan.
- **Visual Aid**:
  ```mermaid
  graph TD
    P((You)) -- "+" --> B((Brother))
    P -- "+" --> S((Sister))
    B -- "Support (+)" --> D{Democrats}
    S -- "Oppose (-)" --> D
    P -.->|Ambivalent / Independent| D
  ```

---

## Part 3: Structural Balance Theory & Whole-Network Polarization (Slides 13–17)

### Slide 13: From Triads to the Whole Network
- **Title**: Structural Balance at the Network Level
- **Core Concepts**: **Structural Balance Theory**, **Complete Signed Graphs**, **Adjacency Representation**
- **Content**:
  - Extends Heider's ideas from individual cognitive triads to the **whole network** level.
  - Traditional structural balance theory operates on **complete signed graphs** (where every pair of actors is connected by either a positive or negative link).
  - In a **signed adjacency matrix**, positive links are $+1$, negative links are $-1$, and disconnected vertices are $0$.
- **Visual Aid**:
  ```mermaid
  graph LR
    A((A)) -- "+" --> B((B))
    B -- "+" --> C((C))
    C -- "-" --> D((D))
    D -- "+" --> E((E))
    A -- "-" --> E
  ```

### Slide 14: The Fundamental Theorem of Structural Balance
- **Title**: Cartwright & Harary’s Fundamental Theorem
- **Core Concepts**: **Cartwright and Harary (1956)**, **Fundamental Theorem of Structural Balance**, **Factionalization**
- **Content**:
  - Discovered by mathematicians Dorwin Cartwright and Frank Harary in 1956.
  - **Theorem**: If a complete signed graph contains *only* balanced triads, the entire graph is balanced.
  - **The Partition Rule**: A balanced graph can be partitioned into exactly **two mutually exclusive factions** such that:
    1. Only positive links exist *within* each faction.
    2. Only negative links exist *between* the two factions.
  - Implies that structural balance is mathematically equivalent to perfect **group polarization**.
- **Visual Aid**:
  ```mermaid
  graph LR
    subgraph Faction 1
      A((A)) -- "+" --- B((B))
      B -- "+" --- C((C))
      C -- "+" --- A
    end
    subgraph Faction 2
      D((D)) -- "+" --- E((E))
      E -- "+" --- F((F))
      F -- "+" --- D
    end
    Faction 1 ---|All Negative Links (-)| Faction 2
  ```

### Slide 15: Signed Matrices & Faction Detection
- **Title**: Rearranging Adjacency Matrices for Polarization
- **Core Concepts**: **Signed Adjacency Matrix**, **Block-Diagonal Rearrangement**, **Faction Permutation**
- **Content**:
  - In a balanced, polarized network, we can perfectly identify factions by rearranging rows and columns.
  - Permuting the matrix groups nodes of the same faction together, yielding a **block-diagonal signed matrix**.
  - Within-faction diagonal blocks are entirely filled with $+1$ (except the main diagonal), while off-diagonal between-faction blocks are entirely filled with $-1$.
- **Visual Aid**: A block-matrix diagram showing the positive and negative regions.
  $$M = \begin{pmatrix}
    \begin{array}{ccc|ccc}
      \mathbf{+} & \mathbf{+} & \mathbf{+} & - & - & - \\
      \mathbf{+} & \mathbf{+} & \mathbf{+} & - & - & - \\
      \mathbf{+} & \mathbf{+} & \mathbf{+} & - & - & - \\ \hline
      - & - & - & \mathbf{+} & \mathbf{+} & \mathbf{+} \\
      - & - & - & \mathbf{+} & \mathbf{+} & \mathbf{+} \\
      - & - & - & \mathbf{+} & \mathbf{+} & \mathbf{+}
    \end{array}
  \end{pmatrix}$$

### Slide 16: Cycles and Paths in Balanced Graphs
- **Title**: The Logic of Paths and Cycles
- **Core Concepts**: **Cycles**, **Paths**, **Boundary Crossings**, **Sign Product**
- **Content**:
  - Structural balance enforces rigid rules on paths and cycles:
  - **Cycles**: All cycles in a balanced signed graph must have a positive sign product.
    - *Within-group cycles*: All edges are $+$, product is positive.
    - *Cross-group cycles*: Must cross the division boundary an *even* number of times to return to start; even number of negative links yields a positive product.
  - **Paths**: 
    - Paths with start/end in the *same* group have a **positive product** (even boundary crossings).
    - Paths with start/end in *different* groups have a **negative product** (odd boundary crossings).
- **Visual Aid**:
  ```mermaid
  graph LR
    subgraph Group 1
      A((Start)) -- "+" --> B((Node B))
    end
    subgraph Group 2
      C((Node C)) -- "+" --> D((End))
    end
    B -- "-" --> C
    D -- "-" --> A
    style A fill:#3b82f6,color:#fff
    style D fill:#a855f7,color:#fff
  ```

### Slide 17: Empirical Case Study: Political Blogs
- **Title**: polarization in the Blogosphere (Adamic & Glance 2005)
- **Core Concepts**: **Political Polarization**, **Echo Chambers**, **Negative Inter-Group Ties**
- **Content**:
  - Balance theory does *not* mean a peaceful state; it describes a state of **maximal polarization and conflict**.
  - Landmark Study: Adamic & Glance (2005) examined the network of political bloggers during the 2004 US Election.
  - Discovered two massive, highly clustered communities (Liberals and Conservatives).
  - Hyperlinking patterns showed intense positive/supportive links within communities, but negative/hostile links between them (illustrating Harary's partition perfectly).
- **Visual Aid**: A schematic layout showing two tightly-knit spheres of influence with dense, thin negative ties between them.
  ```mermaid
  graph LR
    subgraph Liberal Blogs (Cluster A)
      A1((A1)) --- A2((A2))
      A2 --- A3((A3))
    end
    subgraph Conservative Blogs (Cluster B)
      B1((B1)) --- B2((B2))
      B2 --- B3((B3))
    end
    A2 -.->|Negative Link| B1
    A3 -.->|Negative Link| B3
    style A1 fill:#3b82f6
    style B1 fill:#ef4444
  ```

---

## Part 4: Clusterability and Multi-Group Partitioning (Slides 18–20)

### Slide 18: Beyond Two Factions: Davis's Theorem
- **Title**: Clusterability: Generalizing Structural Balance
- **Core Concepts**: **James Davis (1967)**, **Clusterability Theorem**, **Multi-Factionalization**
- **Content**:
  - The Cartwright-Harary model forces a division into exactly *two* factions.
  - This is too restrictive for many social settings (e.g., school cliques, multi-party parliaments, gang rivalries).
  - In 1967, sociologist James Davis generalized structural balance to allow for division into **any number of distinct clusters** ($k \ge 2$).
- **Visual Aid**:
  ```mermaid
  graph TD
    subgraph Cluster 1 (Red)
      A((A)) --- B((B))
    end
    subgraph Cluster 2 (Blue)
      C((C)) --- D((D))
    end
    subgraph Cluster 3 (Yellow)
      E((E)) --- F((F))
    end
    Cluster 1 -.->|Negative| Cluster 2
    Cluster 2 -.->|Negative| Cluster 3
    Cluster 3 -.->|Negative| Cluster 1
  ```

### Slide 19: The All-Negative Triad Rule
- **Title**: Relaxing the Rules of Balance
- **Core Concepts**: **All-Negative Triad**, **Clusterable Graph**, **Clustering Criterion**
- **Content**:
  - Classical balance theory considers a triad with three negative ties (everyone hates everyone else) to be *unbalanced* because it creates tension.
  - Davis argued that in a highly factionalized network, it is perfectly stable for three people from three completely different, competing groups to dislike one another.
  - **The Clustering Criterion**: A graph is **clusterable** if it contains **no triads with exactly one negative tie**.
  - Permitted triads in a clusterable network: all-positive, two-negative, or all-negative triads.
- **Visual Aid**:
  ```mermaid
  graph TD
    subgraph Permitted Triads in Clusterability
      T1((+)) -- "+" --> T2((+))
      T2 -- "+" --> T3((+))
      T3 -- "+" --> T1
      
      U1((+)) -- "-" --> U2((+))
      U2 -- "-" --> U3((+))
      U3 -- "+" --> U1
      
      V1((+)) -- "-" --> V2((+))
      V2 -- "-" --> V3((+))
      V3 -- "-" --> V1
    end
  ```

### Slide 20: Structural Comparison: Balance vs. Clusterability
- **Title**: Balance vs. Clusterability
- **Core Concepts**: **Cartwright-Harary Model**, **Davis Model**, **Partition Limits**
- **Content**:
  - Compare how local triadic configurations impact global structures.
  - Reducing constraints (allowing the all-negative triad) shifts the global network from a strict **bipartite polarization** to **k-partite fragmentation**.
- **Visual Aid**: A structured comparison table.
  | Property | Cartwright-Harary Structural Balance | James Davis Clusterability |
  | :--- | :--- | :--- |
  | **Permitted Triads** | Zero or Two negative links | Zero, Two, or Three negative links |
  | **Forbidden Triads** | One or Three negative links | Exactly One negative link |
  | **Global Structure** | Exactly **two factions** ($k=2$) | Any number of **clusters** ($k \ge 1$) |
  | **Within-Cluster Ties** | Entirely positive ($+$) | Entirely positive ($+$) |
  | **Between-Cluster Ties** | Entirely negative ($-$) | Entirely negative ($-$) |

---

## Part 5: Theoretical Extensions of Balance: Valenced Interaction Theories (Slides 21–24)

### Slide 21: Karma Theory
- **Title**: "You Get What You Spread Out"
- **Core Concepts**: **Karma Theory**, **Direct Reciprocity**, **Valenced Indegree/Outdegree**
- **Content**:
  - A modern social psychological theory explaining expected tie configurations in sentiment networks.
  - Core idea: individuals tend to receive the sentiments they broadcast to the network.
  - Predicts **valenced indegree** (the sentiments one receives) based on **valenced outdegree** (the sentiments one sends).
  - Captures phenomena like direct reciprocity: "bullies get bullied" and "likers get liked".
- **Visual Aid**:
  ```mermaid
  graph LR
    subgraph Karma Flow
      A((A - Positive Spreader)) -- "Positive (+)" --> B((B - Receiver))
      C((C - Sender)) -- "Positive (+)" --> A
      
      X((X - Negative Spreader)) -- "Negative (-)" --> Y((Y - Receiver))
      Z((Z - Sender)) -- "Negative (-)" --> X
    end
    style A fill:#d4edda,stroke:#28a745
    style X fill:#f8d7da,stroke:#dc3545
  ```

### Slide 22: Status Theory
- **Title**: Social Prestige and Sentiment Alignment
- **Core Concepts**: **Status Theory**, **Prestige Alignment**, **Rich-Get-Richer Effect**
- **Content**:
  - Suggests sentiments towards an alter are driven by how *others* in the network feel about that same alter (prestigious alignment).
  - High status = receiving many positive ties; Low status = receiving many negative ties.
  - Positive tie from Ego to Alter $\implies$ Ego views Alter as higher status.
  - Negative tie from Ego to Alter $\implies$ Ego views Alter as lower status.
  - Promotes structural effects: the "rich-get-richer" effect (high-status accumulate positive ties) and "gang-up" effect (low-status accumulate negative ties).
- **Visual Aid**:
  ```mermaid
  graph TD
    A((A - High Status))
    B((B - Low Status))
    C((Ego)) -- "Deference (+)" --> A
    C -- "Dominance (-)" --> B
    style A fill:#fdfd96,stroke:#f8e71c,stroke-width:3px
    style B fill:#e2e8f0,stroke:#64748b,stroke-width:1px
  ```

### Slide 23: Solidarity Theory
- **Title**: Shared Structural Positions and Unity
- **Core Concepts**: **Solidarity Theory**, **Structural Equivalence**, **Status Solidarity**
- **Content**:
  - Posits that individuals feel positively towards others who occupy **similar structural positions** in the sentiment network, and negatively towards those in different positions.
  - Focuses on **structural equivalence**: popular actors form positive ties with other popular actors ("cool kids stick together").
  - Conversely, disliked or downtrodden actors are predicted to form positive bonds with each other ("downtrodden stick together").
- **Visual Aid**: Horizontal positive ties within tiers, vertical deference/dominance ties between tiers.
  ```mermaid
  graph TD
    subgraph Elite Tier
      A((A)) -- "Solidarity (+)" --> B((B))
    end
    subgraph Subordinate Tier
      C((C)) -- "Solidarity (+)" --> D((D))
    end
    C -- "Deference (+)" --> A
    A -- "Dominance (-)" --> C
    style A fill:#fdfd96,stroke:#f8e71c
    style B fill:#fdfd96,stroke:#f8e71c
    style C fill:#93c5fd,stroke:#3b82f6
    style D fill:#93c5fd,stroke:#3b82f6
  ```

### Slide 24: Summary & The Modern Landscape
- **Title**: Modeling Positive and Negative Relationships
- **Core Concepts**: **Signed Network Analysis**, **Dynamic Realignment**, **Polarization Modeling**
- **Content**:
  - Synthesis of how local psychological motivations (Heider) generate global structures (Cartwright-Harary, Davis).
  - Valenced interactions (Karma, Status, Solidarity) provide the micro-foundations for signed network dynamics.
  - Modern research applications: tracking online toxicity, international conflict alliances, organizational factions, and algorithmic echo chambers.
- **Visual Aid**: A comprehensive conceptual flowchart.
  ```mermaid
  graph LR
    A["Micro-motives <br> (Heider's Cognitive Balance)"] -->|Triadic Aggregation| B["Meso-structures <br> (Factions/Cliques)"]
    B -->|Network-wide Convergence| C["Macro-patterns <br> (Structural Balance / Davis Clustering)"]
  ```

---

## Action Plan & Steps to Create the Slide Deck

To build this slide deck in a high-quality presentation format (e.g., a Quarto Revealjs slideshow, matching the format of `slides/ties-motifs.qmd`), the following steps will be taken:

1. **Verify Style Alignment**: Ensure that the theme, colors (such as `#2c3e50` and `#e74c3c`), and styles match the existing UCLA Quarto slide styling (`ucla-theme.css`).
2. **Draft the Quarto Slideshow (`.qmd`)**: Create a new, structured presentation file `slides/balance-signed-graphs.qmd` containing the compiled slides.
3. **Embed Programmatic Visualizations**: Use R code chunks (with `igraph`, `ggraph`, and `tidygraph`) to generate beautiful, crisp network plots for the slides, replicating the existing textbook and slide plotting conventions (using custom manual layouts for maximum clarity).
4. **Compile and Quality Control**: Run the Quarto compilation locally to produce the HTML output, verifying that all equations, formatting, and figures render seamlessly.
