# 📘 Developer Note — Redux Validation Roadmap (Public Edition)

Expanded Tests, Verification Strategy, and Build‑Coherence Guidelines

Redux has reached structural completeness: the manifold, operator suite, domain embeddings, invariant stack, and runtime are fully implemented. The next phase focuses on validation, formalization, and long‑term stability. This document outlines the recommended next steps for contributors and maintainers.

---

🧪 1. Expanded Test Suite (Highest Priority)
The current test scaffold provides a strong foundation, but several modules still require executable tests. Completing these ensures correctness before formal verification or CI automation.

Operator Tests to Add
These verify altitude‑clean behavior and operator stability:

- CurvatureEnvelope  
  - curvature envelope continuity  
  - envelope scaling under perturbation  
- HolonomyField  
  - holonomy transport preserves vector dimension  
  - holonomy drift remains bounded  
- TopologyOperator  
  - topology signature stability  
  - signature monotonicity under structured perturbations  
- FusionOperator  
  - fused geometry dimension correctness  
  - fusion energy positivity and boundedness  

Domain Tests to Add
These ensure embeddings are coherent and dimension‑correct:

- MarkowitzFrontier  
  - convex portfolio embedding  
  - Lagrange multiplier threshold behavior  
- BlackScholesVol  
  - volatility embedding  
  - ATM/OTM/ITM phase‑transition behavior  
- RenyiEntropy  
  - β‑shift embedding  
  - entropy loss per iteration  

Invariant Tests to Add
These validate the mathematical structure of the invariant stack:

- QuantizationInvariant  
  - monotonicity under ternary jumps  
- ConvexityInvariant  
  - convexity energy positivity  
- EntropyShiftInvariant  
  - entropy‑shift sensitivity  
  - fusion‑weighted entropy stability  

Completing these tests ensures the system behaves deterministically and altitude‑clean across all modules.

---

🧬 2. Lean Verification (After Expanded Tests)
Lean formalization should begin only once operator and invariant behavior is stable. Lean is a proof tool, not a debugging tool; therefore, expanded tests must come first.

Recommended Lean obligations:

- manifold axioms  
- operator obligations (spectral, curvature, holonomy, topology, fusion)  
- invariant correctness proofs  
- runtime coherence proofs  

Lean verification becomes significantly easier once the expanded tests confirm stable behavior.

---

⚙️ 3. CI Workflow (After Expanded Tests)
Continuous Integration should be added once the full test suite is executable. CI ensures:

- deterministic behavior across environments  
- regression prevention  
- altitude‑clean transitions remain stable  
- invariants remain monotonic  

Recommended CI stack:

- GitHub Actions  
- Julia 1.9+ matrix  
- test runner  
- optional coverage reporting  

CI without a complete test suite provides little value, so it should follow expanded tests.

---

🚀 4. Benchmarking (After CI)
Benchmarking is an engineering phase focused on performance, not correctness. It should begin only after:

- expanded tests are complete  
- CI is active  
- Lean verification is underway or complete  

Benchmarks will measure:

- operator performance  
- runtime throughput  
- invariant computation cost  
- perturbation‑response speed  

This phase is optional but recommended for long‑term research stability.

---

📦 5. Do We Need .json Files?

Short answer: No — not yet.

Redux does not currently require .json configuration files because:

- all operators are internal  
- all invariants are internal  
- all domain embeddings are internal  
- the runtime is deterministic  
- no external dependency graph exists  
- no dynamic configuration is needed  

When .json would be useful:
If future contributors want:

- dynamic operator weights  
- runtime configuration profiles  
- domain‑specific parameter presets  
- reproducible experiment configurations  
- CI‑driven parameter sweeps  

Then .json files become valuable.

For now, the build is coherent without them.

---

🧭 Recommended Order of Work (Actionable)

1. Complete expanded tests  
2. Begin Lean verification  
3. Add CI workflow  
4. Add benchmarks  
5. Introduce .json configs only if future work requires dynamic parameters

This is the academically defensible, engineering‑sound, and geometry‑aligned order.

---

