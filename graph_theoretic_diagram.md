```mermaid
graph TD
    A[Ties] --> B{Directionality};
    B --> C[Symmetric / Undirected];
    B --> D[Asymmetric / Directed];
    D --> E[Reciprocal (A <--> B)];
    D --> F[Non-Reciprocal (A --> B)];
    D --> G[Anti-Reciprocal (A --> B implies NOT B --> A)];

    subgraph "Examples"
      C --> C1("is sibling of");
      C --> C2("co-worker");
      E --> E1("likes / is friends with");
      F --> F1("sends email to");
      G --> G1("is parent of");
    end

    style C fill:#f9f,stroke:#333,stroke-width:2px;
    style D fill:#ccf,stroke:#333,stroke-width:2px;
```
: A Graph-Theoretic Classification of Ties {#fig-graph-theoretic-ties}