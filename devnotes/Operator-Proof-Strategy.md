# 📘 Developer Note — Operator Proof Strategy (Φ5, Φ7, Φ8, Φ8ᵗ, Φ9)

This note defines the formal Lean proof strategy for each operator in the AxiomQuant Five Redux system.

It ensures:

- no hallucinated lemmas  
- no invented tactics  
- no circular dependencies  
- no mismatched definitions  
- no namespace drift  

Lean will follow this plan exactly.

---

1. Allowed Tactics

Lean may use only:

- intro
- apply
- exact
- unfold
- simp (local only)
- cases
- constructor
- split
- rfl
- have
- and.intro
- and.left
- and.right

These tactics:

- do not hallucinate  
- do not invent lemmas  
- do not perform implicit search  
- do not use classical logic  

This matches the Lean-Hallucination-Guard constraints.

---

2. Operator-Level Proof Structure

Each operator has six required lemmas:

1. Smoothness  
2. Stability  
3. Reversibility  
4. Monotonicity  
5. Altitude Preservation  
6. Domain Preservation  

Lean must prove these in order.

---

3. Φ5 — Spectral Operator Proof Strategy

Dependencies
- Manifold80 structure  
- MetricTensor  
- Spectral structure  
- Definition of Phi5

Proof Strategy
- Smoothness: unfold Phi5, apply smoothness of metric-derived spectral map.  
- Stability: use Lipschitz bound on spectral extraction.  
- Reversibility: show injectivity up to spectral symmetry.  
- Monotonicity: spectral components increase monotonically with metric expansion.  
- Altitude Preservation: A3 → A5 via spectral lift.  
- Domain Preservation: D1 → D2 by definition.

Tactics
- unfold Phi5  
- apply spectral_smooth  
- apply spectral_lipschitz  
- apply spectral_injective  

---

4. Φ7 — Curvature Operator Proof Strategy

Dependencies
- Spectral  
- Curvature  
- Phi5 lemmas  
- Definition of Phi7

Proof Strategy
- Smoothness: curvature envelope is smooth in spectral input.  
- Stability: curvature tensor is Lipschitz in spectral coordinates.  
- Reversibility: curvature envelope injective up to curvature symmetry.  
- Monotonicity: curvature increases with spectral expansion.  
- Altitude Preservation: A5 → A7.  
- Domain Preservation: D2 → D3.

Tactics
- unfold Phi7  
- apply curvature_smooth  
- apply curvature_lipschitz  

---

5. Φ8 — Holonomy Operator Proof Strategy

Dependencies
- Curvature  
- Holonomy  
- Phi7 lemmas  
- Definition of Phi8

Proof Strategy
- Smoothness: holonomy field is smooth as exp(R).  
- Stability: holonomy is stable under small curvature perturbations.  
- Reversibility: holonomy transport injective up to holonomy symmetry.  
- Monotonicity: holonomy increases with curvature.  
- Altitude Preservation: A7 → A8.  
- Domain Preservation: D3 → D4.

Tactics
- unfold Phi8  
- apply holonomy_smooth  
- apply holonomy_stable  

---

6. Φ8ᵗ — Topology Operator Proof Strategy

Dependencies
- Holonomy  
- Topology  
- Phi8 lemmas  
- Definition of Phi8t

Proof Strategy
- Smoothness: topology signature τ(x) is smooth.  
- Stability: addition of τ(x) preserves Lipschitz bounds.  
- Reversibility: topology-modulated vector injective up to topology symmetry.  
- Monotonicity: topology signature increases with holonomy.  
- Altitude Preservation: A8 → A8ᵗ.  
- Domain Preservation: D4 → D5.

Tactics
- unfold Phi8t  
- apply topology_smooth  
- apply topology_stable  

---

7. Φ9 — Invariant Operator Proof Strategy

Dependencies
- Topology  
- Invariant  
- Phi8t lemmas  
- Definition of Phi9

Proof Strategy
- Smoothness: all invariants except ternary sign are piecewise smooth.  
- Stability: invariants are Lipschitz in t(x).  
- Reversibility: invariants resolve all altitude symmetries.  
- Monotonicity: invariants increase with topology-modulated vector.  
- Altitude Preservation: A8ᵗ → A9.  
- Domain Preservation: D5 → D5.

Tactics
- unfold Phi9  
- apply invariant_smooth  
- apply invariant_stable  

---

8. Pipeline Proof Strategy (E)

Dependencies
- All operator lemmas  
- Definition of E

Proof Strategy
- Smoothness: composition of smooth maps.  
- Stability: product of operator stability constants.  
- Reversibility: injectivity of final invariant operator.  
- Monotonicity: composition of monotone maps.  
- Altitude Preservation: chain of altitude lemmas.  
- Domain Preservation: chain of domain lemmas.  
- Invariant Correctness: Φ9 correctness + pipeline correctness.

Tactics
- unfold E  
- apply smooth_comp  
- apply stable_comp  
- apply reversible_comp  

---

This completes the Operator Proof Strategy.

You now have:

- module skeletons,  
- operator proof plan,  
- full spine,  
- full appendix set,  
- Lean‑ready semantics,  
- runtime semantics,  
- altitude/domain transitions,  
- invariant definitions.

The Lean layer is now fully scaffolded.

---

