# Expanded Test Suite Overview — Geometry Validation Lab

---

🎨 Color Tile Legend
| Tile | Meaning |
|------|---------|
| 🟦 Operator Tests | Validate spectral, curvature, holonomy, topology, fusion |
| 🟩 Domain Tests | Validate embeddings for graphs, ternary, frontier, vol, entropy |
| 🟧 Invariant Tests | Validate connectivity, quantization, convexity, canonical, entropy‑shift |
| 🟪 Runtime Tests | Validate full pipeline behavior |
| 🟥 Stability Tests | Stress, perturbation, altitude‑clean |
| 🟨 Integration Tests | End‑to‑end geometry validation |

---

🧪 Welcome to the Redux Geometry Test Lab
This folder contains the complete validation suite for the Redux geometric‑AI engine.  
Every test here ensures that the manifold, operators, domains, invariants, and runtime behave correctly, coherently, and altitude‑clean.

Redux is a scientific instrument, not a neural network — and this folder is where we prove it.

---

🟦 Operator Tests
Located in: test/operators/

These tests validate the five core geometric operators:

- Spectral — frequency structure  
- Curvature — geometric stress  
- Holonomy — transport behavior  
- Topology — connectivity signature  
- Fusion — final geometry blend  

Each operator must:

- preserve dimension  
- produce finite values  
- remain stable under perturbation  
- behave coherently relative to other operators  

---

🟩 Domain Tests
Located in: test/domains/

These tests validate embeddings for the five threshold domains:

- Erdős graph geometry  
- BitNet ternary geometry  
- Markowitz frontier geometry  
- Black‑Scholes volatility geometry  
- Rényi entropy geometry  

Each embedding must:

- map correctly into the manifold  
- preserve dimension  
- remain finite  
- behave consistently under stress  

---

🟧 Invariant Tests
Located in: test/invariants/

These tests validate the five scalar invariants:

- Connectivity  
- Quantization  
- Convexity  
- Canonical‑Form  
- Entropy‑Shift  

Each invariant must be:

- positive  
- finite  
- stable  
- altitude‑clean  

---

🟪 Runtime Tests
Located in: test/runtime/

These tests validate the full geometry pipeline:

`
domain → manifold → operators → fusion → invariants
`

Runtime tests ensure:

- deterministic behavior  
- dimension correctness  
- invariant positivity  
- coherent operator sequencing  

---

🟥 Stability Tests
Located in: test/stability/

These tests push the system to extremes:

- Stress tests — huge or tiny inputs  
- Perturbation tests — micro‑changes  
- Altitude‑clean tests — A8 → A3 → A2 → A1 transitions  

These ensure Redux behaves like a real geometric system under pressure.

---

🟨 Integration Tests
Located in: test/runtime/integration_tests.jl

These tests run the entire engine end‑to‑end across all domains.  
They validate:

- manifold coherence  
- operator consistency  
- invariant stability  
- runtime correctness  

This is the “full factory run.”

---

🔧 Build Coherence Notes
- No .json configuration files are required at this stage.  
- All operators, invariants, and embeddings are deterministic.  
- CI workflows should run the entire test suite.  
- Lean verification should begin only after all tests pass consistently.

---

🚀 Next Steps
- CI workflow  
- Lean verification spine  
- Benchmarks  
- Public README  

---

