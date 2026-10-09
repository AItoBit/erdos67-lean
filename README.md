# Erdős 67: finite discrepancy and compactness reductions

This repository proves **partial results** associated with the Erdős discrepancy theorem. It does **not** contain a complete Lean proof of the real or complex unbounded-discrepancy theorem.

The unconditional finite theorem says that every sequence of signs has a homogeneous arithmetic progression ending at or before 12 whose sum has absolute value greater than 1. A second result establishes the equivalence between unbounded discrepancy for each sequence and a finite horizon for each threshold that works for every sequence. The remaining results verify natural-threshold and sign-representation changes, and the implication from complex discrepancy to real discrepancy.

These elementary results provide an explicit finite test case and a compactness interface for work on discrepancy. No mathematical novelty, full solution, human expert review, or source-author endorsement is claimed. The intended audience is researchers working with discrepancy, finite certificates, and formalizations of standard reductions; Palomar's editorial review independently assesses suitability.

## Exact submission scope

`Challenge.lean` is the standalone mathematical statement. Its only imports are from pinned Mathlib. `Solution.lean` imports the actual proofs. `comparator.json` selects exactly these six theorems:

| Theorem in namespace `Erdos67` | Mathematical content |
|---|---|
| `discrepancy_one_at_twelve` | Every sign sequence has a progression with `d,m ≥ 1`, `d*m ≤ 12`, and absolute sum greater than 1. |
| `discrepancyStatement_iff_uniformFiniteStatement` | Full discrepancy is equivalent to a horizon `N` for each natural threshold `B`, with `N` selected before the sequence. Neither side is proved here. |
| `discrepancyStatement_iff_naturalThresholdStatement` | Positive real thresholds and all natural thresholds give equivalent targets. |
| `realSubtypeDiscrepancyStatement_iff_discrepancyStatement` | Integer signs and real signs in the subtype `{-1,1}` give equivalent targets. |
| `realSubtypeDiscrepancyStatement_of_complexDiscrepancyStatement` | The full complex assertion implies the real subtype assertion. The complex assertion is an explicit hypothesis. |
| `discrepancyStatement_of_complexDiscrepancyStatement` | The same conditional implication to integer signs. |

All target definitions have concrete ordinary mathematical meanings. No definition is left unspecified. The six deliberate `sorry` holes in Challenge are statement placeholders for independent comparison; the Solution dependency closure has no proof holes or custom mathematical axioms.

## Proofs and sources

`Erdos67/FiniteBound.lean` derives the bound at 12 from nine progression constraints using integer arithmetic. Two exact enumeration methods in `research/exhaustive_bound_one.py` separately examine all 4,096 assignments at length 12 and 2,048 at length 11. They find no assignment bounded by 1 at length 12 and four at length 11. The enumeration is supporting evidence and is not part of the Lean proof.

The finite result is already known: see Konev and Lisitsa, [*Computer-Aided Proof of Erdős Discrepancy Properties*](https://arxiv.org/abs/1405.3097), Section 2, the finite discrepancy-one example. Our elementary Lean proof was constructed independently. Their stronger discrepancy-two SAT result is outside this development.

`Erdos67/Compactness.lean` covers the compact product space of sign sequences by open sets witnessing discrepancy, extracts a finite subcover, and takes the maximum progression endpoint. This proves the quantifier rearrangement; it does not establish unbounded discrepancy.

`Erdos67/Complex.lean` uses the isometric real-to-complex embedding and finite-sum compatibility. It does not prove the complex theorem.

The full mathematical theorem is Tao, *The Erdős discrepancy problem*, [Discrete Analysis 2016:1](https://discreteanalysisjournal.com/article/609-the-erdos-discrepancy-problem), DOI 10.19086/da.609 ([arXiv v6](https://arxiv.org/html/1509.05363v6)), Theorem 1.1 and Corollary 1.2. The problem is [Erdős 67](https://www.erdosproblems.com/67). The supplied targets also appear in [Formal Conjectures at revision 87d97fa](https://github.com/google-deepmind/formal-conjectures/blob/87d97fa7626c7b39ee4c8565d3acfa5a048d6cae/FormalConjectures/ErdosProblems/67.lean), where both full proofs remain placeholders.

The [full-proof dependency audit](PROOF_STATUS.md) records the outstanding analytic dependencies. Historical research notes concern the unachieved full theorem and must not be read as claims about this smaller submission. The [target audit](research/complex-target-audit.md) records source fidelity.

## Verification

The project pins Lean `4.35.0-rc2` and Mathlib `065356127b1dc0016f66b7283ce0ce2c4055aa55`. Transitive dependencies are pinned in `lake-manifest.json`.

```sh
lake exe cache get
lake build Erdos67 Erdos67.Compactness Erdos67.FiniteBound Erdos67.Complex Challenge Solution
lake env lean CheckAxioms.lean
```

The substantive modules compiled locally, and all six compared theorems depend only on `propext`, `Classical.choice`, and `Quot.sound`; see `verification/complex-axioms.txt`. Independent AI mathematical audits passed. Historical logs retain the environment and result actually checked; they do not imply checks of later revisions.

[Palomar mechanical preflight](https://github.com/AItoBit/erdos67-lean/actions/workflows/preflight.yml) runs the complete pinned Palomar reusable workflow with `mode: full`, including Comparator and independent kernel verification. A submission uses the exact public commit whose mechanical report passes. A build alone is not Palomar approval or registration. The registry's editorial review and the user's final registration decision are separate steps.

## Provenance and license

Maintainer: alexander. Developed with AI assistance using Codex and the Erdős Research Orchestrator, with a separate AI mathematical auditor. Detailed sources, roles, scope, and limitations are in `formalization.yaml`. This repository is the substantive development and retains its **Apache 2.0** license.
