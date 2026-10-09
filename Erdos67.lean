module

public import Mathlib.Algebra.BigOperators.Group.Finset.Basic
public import Mathlib.Algebra.Order.Archimedean.Real.Basic
public import Mathlib.Basic.Real.Basic
public import Mathlib.Order.Interval.Finset.Nat

/-!
Statement of Erdős Problem 67 (the Erdős discrepancy theorem).
Source: https://www.erdosproblems.com/67 and the supplied 67palomar.pdf.
Mathematical proof: Terence Tao, The Erdős discrepancy problem,
Discrete Analysis 2016:1, Corollary 1.2, https://arxiv.org/abs/1509.05363.

This file defines the exact target. It does not provide a proof of that target.
The quantitative variants and the Hilbert-space generalization are outside its scope.
-/

@[expose] public section

namespace Erdos67

/-- A sequence of signs. Index zero never occurs in the progressions below. -/
def SignSequence (f : ℕ → ℤ) : Prop :=
  ∀ n, f n = -1 ∨ f n = 1

/-- The sum over the first `m` positive multiples of `d`. -/
def progressionSum (f : ℕ → ℤ) (d m : ℕ) : ℤ :=
  ∑ k ∈ Finset.Icc 1 m, f (k * d)

/-- Every sign sequence has unbounded homogeneous arithmetic progression sums.
The witnesses `d` and `m` may depend on both the sequence and the threshold. -/
def DiscrepancyStatement : Prop :=
  ∀ f : ℕ → ℤ, SignSequence f →
    ∀ C : ℝ, 0 < C →
      ∃ d m : ℕ, 1 ≤ d ∧ 1 ≤ m ∧ C < |(progressionSum f d m : ℝ)|

/-- Equivalent proof target using only natural-number thresholds. -/
def NaturalThresholdStatement : Prop :=
  ∀ f : ℕ → ℤ, SignSequence f →
    ∀ B : ℕ,
      ∃ d m : ℕ, 1 ≤ d ∧ 1 ≤ m ∧ (B : ℝ) < |(progressionSum f d m : ℝ)|

/-- Reducing the thresholds to natural numbers does not weaken the full target.
This equivalence does not prove either discrepancy statement. -/
theorem discrepancyStatement_iff_naturalThresholdStatement :
    DiscrepancyStatement ↔ NaturalThresholdStatement := by
  constructor
  · intro h f hf B
    obtain ⟨d, m, hd, hm, hB⟩ := h f hf (B + 1 : ℕ)
      (Nat.cast_pos.mpr (Nat.succ_pos B))
    exact ⟨d, m, hd, hm, lt_of_le_of_lt (Nat.cast_le.mpr (Nat.le_succ B)) hB⟩
  · intro h f hf C _hC
    obtain ⟨B, hCB⟩ := exists_nat_gt C
    obtain ⟨d, m, hd, hm, hB⟩ := h f hf B
    exact ⟨d, m, hd, hm, hCB.trans hB⟩

end Erdos67
