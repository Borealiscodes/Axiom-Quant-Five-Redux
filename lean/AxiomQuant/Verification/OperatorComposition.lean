-- AxiomQuant-Five-Redux/lean/AxiomQuant/Verification/OperatorComposition.lean

import AxiomQuant.Core
import AxiomQuant.Operators.Holonomy

namespace AxiomQuant

/-
  Phase 4: Cross-Operator Verification Layer
  ------------------------------------------
  This module provides the general lemmas for verifying
  smoothness, stability, reversibility, monotonicity,
  altitude preservation, and domain preservation across
  compositions of operators.
-/

/- ---------------------------------------------------------
   Lemma 1: Smoothness of operator composition
   --------------------------------------------------------- -/

lemma smooth_comp {α β γ : Type}
    {f : β → γ} {g : α → β} :
    Smooth f → Smooth g → Smooth (fun x => f (g x)) := by
  intro hf hg
  simpa using hf.comp hg


/- ---------------------------------------------------------
   Lemma 2: Stability of operator composition
   --------------------------------------------------------- -/

lemma stable_comp {α β γ : Type}
    {f : β → γ} {g : α → β}
    {C₁ C₂ : ℝ} :
    (∀ x y, ‖f x - f y‖ ≤ C₁ * ‖x - y‖) →
    (∀ x y, ‖g x - g y‖ ≤ C₂ * ‖x - y‖) →
    ∀ x y, ‖f (g x) - f (g y)‖ ≤ (C₁ * C₂) * ‖x - y‖ := by
  intro hf hg x y
  have h₁ := hf (g x) (g y)
  have h₂ := hg x y
  calc
    ‖f (g x) - f (g y)‖
        ≤ C₁ * ‖g x - g y‖ := h₁
    _ ≤ C₁ * (C₂ * ‖x - y‖) := by
          have := h₂
          simpa [mul_comm, mul_left_comm, mul_assoc] using
            mul_le_mul_of_nonneg_left this (le_of_lt (by decide))
    _ = (C₁ * C₂) * ‖x - y‖ := by ring


/- ---------------------------------------------------------
   Lemma 3: Reversibility of operator composition
   --------------------------------------------------------- -/

lemma reversible_comp {α β γ : Type}
    {f : β → γ} {g : α → β} :
    (∀ x y, f x = f y → x = y) →
    (∀ x y, g x = g y → x = y) →
    ∀ x y, (fun z => f (g z)) x = (fun z => f (g z)) y → x = y := by
  intro hf hg x y h
  have h₁ : g x = g y := hf (g x) (g y) h
  exact hg x y h₁


/- ---------------------------------------------------------
   Lemma 4: Monotonicity of operator composition
   --------------------------------------------------------- -/

lemma monotone_comp {α β γ : Type}
    {f : β → γ} {g : α → β} :
    (∀ x y, x ≤ y → f x ≤ f y) →
    (∀ x y, x ≤ y → g x ≤ g y) →
    ∀ x y, x ≤ y → f (g x) ≤ f (g y) := by
  intro hf hg x y h
  have h₁ := hg x y h
  exact hf (g x) (g y) h₁


/- ---------------------------------------------------------
   Lemma 5: Altitude preservation across composition
   --------------------------------------------------------- -/

lemma altitude_comp {α β γ : Type}
    {f : β → γ} {g : α → β}
    {Aβ : β → Prop} {Aγ : γ → Prop} {Aα : α → Prop} :
    (∀ x, Aβ (g x)) →
    (∀ y, Aγ (f y)) →
    ∀ x, Aγ (f (g x)) := by
  intro hg hf x
  have h₁ := hg x
  exact hf (g x)


/- ---------------------------------------------------------
   Lemma 6: Domain preservation across composition
   --------------------------------------------------------- -/

lemma domain_comp {α β γ : Type}
    {f : β → γ} {g : α → β}
    {Dβ : β → Prop} {Dγ : γ → Prop} {Dα : α → Prop} :
    (∀ x, Dβ (g x)) →
    (∀ y, Dγ (f y)) →
    ∀ x, Dγ (f (g x)) := by
  intro hg hf x
  have h₁ := hg x
  exact hf (g x)

end AxiomQuant
