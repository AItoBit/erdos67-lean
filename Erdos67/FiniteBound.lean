module

public import Erdos67
public import Mathlib.Algebra.BigOperators.Intervals
public import Mathlib.Tactic.NormNum
public import Mathlib.Tactic.NormNum.Abs

/-!
A fixed-threshold instance of the Erdős discrepancy theorem: every sign sequence
has a homogeneous arithmetic progression contained in `1, ..., 12` with absolute
sum greater than one. This does not prove unbounded discrepancy.
-/

@[expose] public section

namespace Erdos67

/-- Discrepancy greater than one is forced by the first twelve signs. -/
theorem discrepancy_one_at_twelve (f : ℕ → ℤ) (hf : SignSequence f) :
    ∃ d m : ℕ, 1 ≤ d ∧ 1 ≤ m ∧ d * m ≤ 12 ∧
      (1 : ℝ) < |(progressionSum f d m : ℝ)| := by
  by_contra h
  have hb (d m : ℕ) (hd : 1 ≤ d) (hm : 1 ≤ m) (hdm : d * m ≤ 12) :
      -1 ≤ progressionSum f d m ∧ progressionSum f d m ≤ 1 := by
    have hr : |(progressionSum f d m : ℝ)| ≤ 1 :=
      le_of_not_gt (fun hB => h ⟨d, m, hd, hm, hdm, hB⟩)
    have hz : |progressionSum f d m| ≤ (1 : ℤ) := by exact_mod_cast hr
    exact abs_le.mp hz
  have h12 := hb 1 2 (by decide) (by decide) (by decide)
  have h14 := hb 1 4 (by decide) (by decide) (by decide)
  have h16 := hb 1 6 (by decide) (by decide) (by decide)
  have h18 := hb 1 8 (by decide) (by decide) (by decide)
  have h110 := hb 1 10 (by decide) (by decide) (by decide)
  have h32 := hb 3 2 (by decide) (by decide) (by decide)
  have h52 := hb 5 2 (by decide) (by decide) (by decide)
  have h62 := hb 6 2 (by decide) (by decide) (by decide)
  have h34 := hb 3 4 (by decide) (by decide) (by decide)
  norm_num [progressionSum, Finset.sum_Icc_succ_top] at h12 h14 h16 h18 h110 h32 h52 h62 h34
  have hs1 := hf 1
  have hs2 := hf 2
  have hs3 := hf 3
  have hs4 := hf 4
  have hs5 := hf 5
  have hs6 := hf 6
  have hs7 := hf 7
  have hs8 := hf 8
  have hs9 := hf 9
  have hs10 := hf 10
  have hs12 := hf 12
  omega

end Erdos67
