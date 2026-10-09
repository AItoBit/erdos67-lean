module

public import Erdos67
public import Mathlib.Topology.Compactness.Compact
public import Mathlib.Topology.Instances.Int
public import Mathlib.Topology.Algebra.Monoid
public import Mathlib.Data.Finset.Lattice.Fold

/-!
The compactness equivalence for the Erdős discrepancy theorem.

For each threshold, the infinite statement is equivalent to the existence of a
finite interval that works uniformly for every sign sequence. Compactness alone
does not establish either discrepancy statement.
-/

@[expose] public section

namespace Erdos67

/-- A uniform finite interval for each natural-number discrepancy threshold. -/
def UniformFiniteStatement : Prop :=
  ∀ B : ℕ, ∃ N : ℕ, ∀ f : ℕ → ℤ, SignSequence f →
    ∃ d m : ℕ, 1 ≤ d ∧ 1 ≤ m ∧ d * m ≤ N ∧
      (B : ℝ) < |(progressionSum f d m : ℝ)|

/-- The set of sign sequences is compact in the product of discrete topologies. -/
theorem isCompact_signSequences : IsCompact {f : ℕ → ℤ | SignSequence f} := by
  simpa [SignSequence] using
    (isCompact_pi_infinite (s := fun _ : ℕ => ({-1, 1} : Set ℤ))
      (fun _ => ((Set.finite_singleton (1 : ℤ)).insert (-1)).isCompact))

/-- Each progression sum depends continuously on finitely many coordinates. -/
theorem continuous_progressionSum (d m : ℕ) :
    Continuous (fun f : ℕ → ℤ => progressionSum f d m) := by
  exact continuous_finsetSum _ (fun k _ => continuous_apply (k * d))

/-- Compactness upgrades pointwise discrepancy to a bound uniform in the sequence. -/
theorem naturalThresholdStatement_iff_uniformFiniteStatement :
    NaturalThresholdStatement ↔ UniformFiniteStatement := by
  classical
  constructor
  · intro h B
    let I := {dm : ℕ × ℕ // 1 ≤ dm.1 ∧ 1 ≤ dm.2}
    let U : I → Set (ℕ → ℤ) := fun dm =>
      {f | (B : ℝ) < |(progressionSum f dm.val.1 dm.val.2 : ℝ)|}
    have hopen : ∀ dm, IsOpen (U dm) := by
      intro dm
      exact (isOpen_discrete {z : ℤ | (B : ℝ) < |(z : ℝ)|}).preimage
        (continuous_progressionSum dm.val.1 dm.val.2)
    have hcover : {f : ℕ → ℤ | SignSequence f} ⊆ ⋃ dm, U dm := by
      intro f hf
      obtain ⟨d, m, hd, hm, hB⟩ := h f hf B
      exact Set.mem_iUnion.mpr ⟨⟨(d, m), hd, hm⟩, hB⟩
    obtain ⟨t, ht⟩ := isCompact_signSequences.elim_finite_subcover U hopen hcover
    refine ⟨t.sup (fun dm => dm.val.1 * dm.val.2), ?_⟩
    intro f hf
    obtain ⟨dm, hdm⟩ := Set.mem_iUnion.mp (ht hf)
    obtain ⟨hmem, hB⟩ := Set.mem_iUnion.mp hdm
    exact ⟨dm.val.1, dm.val.2, dm.property.1, dm.property.2,
      Finset.le_sup (f := fun dm : I => dm.val.1 * dm.val.2) hmem, hB⟩
  · intro h f hf B
    obtain ⟨N, hN⟩ := h B
    obtain ⟨d, m, hd, hm, _, hB⟩ := hN f hf
    exact ⟨d, m, hd, hm, hB⟩

/-- The uniform finite formulation is equivalent to the original real-threshold target. -/
theorem discrepancyStatement_iff_uniformFiniteStatement :
    DiscrepancyStatement ↔ UniformFiniteStatement :=
  discrepancyStatement_iff_naturalThresholdStatement.trans
    naturalThresholdStatement_iff_uniformFiniteStatement

end Erdos67
