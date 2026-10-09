module

public import Mathlib.Algebra.BigOperators.Group.Finset.Basic
public import Mathlib.Algebra.Order.Archimedean.Real.Basic
public import Mathlib.Basic.Real.Basic
public import Mathlib.Order.Interval.Finset.Nat
public import Mathlib.Analysis.Complex.Norm
public import Mathlib.Basic.Complex.BigOperators
public import Mathlib.Topology.MetricSpace.Pseudo.Defs

/-!
# Finite discrepancy and compactness reductions for Erdős 67

The unconditional finite result says that every sequence of signs has a
homogeneous arithmetic progression ending at or before 12 with absolute sum
greater than 1. The other results identify equivalent formulations of the
full discrepancy statement and give a conditional complex-to-real reduction.

The full discrepancy theorem, proved mathematically by Tao (Discrete Analysis
2016:1, doi:10.19086/da.609), is NOT proved in this formalization. Its real and
complex formulations below are concrete proposition definitions. Neither is
assumed globally. The two complex-to-real implications explicitly assume the
complex statement. No mathematical novelty is claimed for these elementary
results. The compactness equivalence makes the dependence of a finite horizon
on the threshold, independently of the sequence, explicit.

The theorem holes in this independent Challenge are intentional. Solution
imports the actual proved declarations; Comparator checks the correspondence.
-/

@[expose] public section

namespace Erdos67

/-- An integer-valued sequence taking only the values -1 and 1. Index zero
does not occur in any progression with positive step and length. -/
def SignSequence (f : ℕ → ℤ) : Prop :=
  ∀ n, f n = -1 ∨ f n = 1

/-- Sum over the first `m` positive multiples of `d`. -/
def progressionSum (f : ℕ → ℤ) (d m : ℕ) : ℤ :=
  ∑ k ∈ Finset.Icc 1 m, f (k * d)

/-- The full unbounded discrepancy assertion, defined but not proved here.
The positive witnesses can depend on both the sequence and the threshold. -/
def DiscrepancyStatement : Prop :=
  ∀ f : ℕ → ℤ, SignSequence f →
    ∀ C : ℝ, 0 < C →
      ∃ d m : ℕ, 1 ≤ d ∧ 1 ≤ m ∧ C < |(progressionSum f d m : ℝ)|

/-- The same proof target with all natural-number thresholds. -/
def NaturalThresholdStatement : Prop :=
  ∀ f : ℕ → ℤ, SignSequence f →
    ∀ B : ℕ,
      ∃ d m : ℕ, 1 ≤ d ∧ 1 ≤ m ∧ (B : ℝ) < |(progressionSum f d m : ℝ)|

/-- A finite horizon for each threshold that works for every sign sequence.
Existence of these horizons for all thresholds is not proved here. -/
def UniformFiniteStatement : Prop :=
  ∀ B : ℕ, ∃ N : ℕ, ∀ f : ℕ → ℤ, SignSequence f →
    ∃ d m : ℕ, 1 ≤ d ∧ 1 ≤ m ∧ d * m ≤ N ∧
      (B : ℝ) < |(progressionSum f d m : ℝ)|

/-- The full real-sign statement in the finite-set subtype representation. -/
def RealSubtypeDiscrepancyStatement : Prop :=
  ∀ f : ℕ → ({-1, 1} : Finset ℝ), ∀ C : ℝ, 0 < C →
    ∃ d m : ℕ, 1 ≤ d ∧ 1 ≤ m ∧
      C < |∑ k ∈ Finset.Icc 1 m, (f (k * d)).1|

/-- The full unit-circle variant, defined but not proved. No multiplicativity
assumption is imposed on the sequence. -/
def ComplexDiscrepancyStatement : Prop :=
  ∀ f : ℕ → Metric.sphere (0 : ℂ) 1, ∀ C : ℝ, 0 < C →
    ∃ d m : ℕ, 1 ≤ d ∧ 1 ≤ m ∧
      C < ‖∑ k ∈ Finset.Icc 1 m, (f (k * d)).1‖

/-- Using natural thresholds does not weaken the full target. This proves
an equivalence, not either side. -/
theorem discrepancyStatement_iff_naturalThresholdStatement :
    DiscrepancyStatement ↔ NaturalThresholdStatement := by
  sorry

/-- Compactness turns the pointwise unboundedness assertion into existence
of a finite horizon for each threshold, uniformly over all sign sequences. -/
theorem discrepancyStatement_iff_uniformFiniteStatement :
    DiscrepancyStatement ↔ UniformFiniteStatement := by
  sorry

/-- The unconditional finite result: discrepancy greater than one occurs
within the first twelve signs. This proves only one threshold. -/
theorem discrepancy_one_at_twelve (f : ℕ → ℤ) (hf : SignSequence f) :
    ∃ d m : ℕ, 1 ≤ d ∧ 1 ≤ m ∧ d * m ≤ 12 ∧
      (1 : ℝ) < |(progressionSum f d m : ℝ)| := by
  sorry

/-- The complex assertion, if proved, implies the real-sign assertion by
the isometric embedding of real numbers into complex numbers. -/
theorem realSubtypeDiscrepancyStatement_of_complexDiscrepancyStatement
    (h : ComplexDiscrepancyStatement) : RealSubtypeDiscrepancyStatement := by
  sorry

/-- Integer signs and real signs represented as a subtype give equivalent
full targets. No full discrepancy theorem is asserted. -/
theorem realSubtypeDiscrepancyStatement_iff_discrepancyStatement :
    RealSubtypeDiscrepancyStatement ↔ DiscrepancyStatement := by
  sorry

/-- Conditional complex-to-integer-sign reduction. The complex discrepancy
assertion remains an explicit hypothesis. -/
theorem discrepancyStatement_of_complexDiscrepancyStatement
    (h : ComplexDiscrepancyStatement) : DiscrepancyStatement := by
  sorry

end Erdos67
