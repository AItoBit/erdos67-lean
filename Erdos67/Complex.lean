module

public import Erdos67
public import Mathlib.Analysis.Complex.Norm
public import Mathlib.Basic.Complex.BigOperators
public import Mathlib.Topology.MetricSpace.Pseudo.Defs

/-!
Exact real-subtype and complex-unit-circle statements supplied for Erdős Problem 67.
The full statements below are proposition definitions, not asserted theorems.
The reductions prove only implications and equivalences between proof targets.
Source: Terence Tao, The Erdős discrepancy problem, arXiv:1509.05363v6,
Theorem 1.1 and Corollary 1.2.
-/

@[expose] public section

namespace Erdos67

/-- The full discrepancy statement for real signs represented by a finite-set subtype. -/
def RealSubtypeDiscrepancyStatement : Prop :=
  ∀ f : ℕ → ({-1, 1} : Finset ℝ), ∀ C : ℝ, 0 < C →
    ∃ d m : ℕ, 1 ≤ d ∧ 1 ≤ m ∧
      C < |∑ k ∈ Finset.Icc 1 m, (f (k * d)).1|

/-- The full complex variant: arbitrary unit-circle sequences have unbounded
homogeneous arithmetic progression sums. No proof of this statement is asserted. -/
def ComplexDiscrepancyStatement : Prop :=
  ∀ f : ℕ → Metric.sphere (0 : ℂ) 1, ∀ C : ℝ, 0 < C →
    ∃ d m : ℕ, 1 ≤ d ∧ 1 ≤ m ∧
      C < ‖∑ k ∈ Finset.Icc 1 m, (f (k * d)).1‖

/-- A complete proof of the complex variant would imply the real-subtype version. -/
theorem realSubtypeDiscrepancyStatement_of_complexDiscrepancyStatement
    (h : ComplexDiscrepancyStatement) : RealSubtypeDiscrepancyStatement := by
  intro f C hC
  let g : ℕ → Metric.sphere (0 : ℂ) 1 := fun n =>
    ⟨((f n).1 : ℂ), by
      have hn := (f n).2
      simp only [Finset.mem_insert, Finset.mem_singleton] at hn
      rw [Metric.mem_sphere, dist_zero_right, Complex.norm_real, Real.norm_eq_abs]
      rcases hn with hn | hn <;> simp only [hn, abs_neg, abs_one]⟩
  obtain ⟨d, m, hd, hm, hsum⟩ := h g C hC
  refine ⟨d, m, hd, hm, ?_⟩
  simpa only [g, ← Complex.ofReal_sum, Complex.norm_real, Real.norm_eq_abs] using hsum

/-- The real-subtype statement and the integer-sign statement are equivalent.
This supplies an exact interface between the two encodings, not a full proof. -/
theorem realSubtypeDiscrepancyStatement_iff_discrepancyStatement :
    RealSubtypeDiscrepancyStatement ↔ DiscrepancyStatement := by
  constructor
  · intro h f hf C hC
    let g : ℕ → ({-1, 1} : Finset ℝ) := fun n =>
      ⟨(f n : ℝ), by
        rcases hf n with hn | hn <;> simp [hn]⟩
    obtain ⟨d, m, hd, hm, hsum⟩ := h g C hC
    refine ⟨d, m, hd, hm, ?_⟩
    simpa [g, progressionSum] using hsum
  · intro h f C hC
    classical
    let g : ℕ → ℤ := fun n => if (f n).1 = -1 then -1 else 1
    have hg : SignSequence g := by
      intro n
      by_cases hn : (f n).1 = -1 <;> simp [g, hn]
    have hgf (n : ℕ) : (g n : ℝ) = (f n).1 := by
      have hn := (f n).2
      simp only [Finset.mem_insert, Finset.mem_singleton] at hn
      have hne : (1 : ℝ) ≠ -1 := ne_of_gt (neg_one_lt_zero.trans zero_lt_one)
      rcases hn with hn | hn
      · simp [g, hn]
      · simp [g, hn, hne]
    obtain ⟨d, m, hd, hm, hsum⟩ := h g hg C hC
    refine ⟨d, m, hd, hm, ?_⟩
    simpa only [progressionSum, Int.cast_sum, hgf] using hsum

/-- A complete proof of the complex variant would also imply the existing
integer-sign target. The complex statement remains an explicit hypothesis. -/
theorem discrepancyStatement_of_complexDiscrepancyStatement
    (h : ComplexDiscrepancyStatement) : DiscrepancyStatement :=
  realSubtypeDiscrepancyStatement_iff_discrepancyStatement.mp
    (realSubtypeDiscrepancyStatement_of_complexDiscrepancyStatement h)

end Erdos67
