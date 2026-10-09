# Full-proof attempt: dependency audit

Status checked on 2026-10-09. **The full Erdős discrepancy theorem is not proved in this repository.** The mathematical theorem is established in the literature. Failure to construct its Lean proof here does not make the mathematical problem open.

## Analytic route

The exact target is `Erdos67.DiscrepancyStatement`. Tao's [paper](https://arxiv.org/html/1509.05363v6) proves its mathematical counterpart as Corollary 1.2. An implementation of that route needs the following steps.

| Node | Input needed | Available formal support | Remaining work |
|---|---|---|---|
| Fourier reduction | A uniform bound on all homogeneous progression sums gives a stochastic completely multiplicative function with bounded second moments | Mathlib has finite-character orthogonality and probability-measure compactness | The finite Fourier construction, estimates, and limit argument have not been proved here |
| Correlation estimate | Tao's logarithmically averaged nonasymptotic Elliott theorem, paper Theorem 1.10 | The pinned library has Dirichlet characters and norm bounds | No matching correlation theorem was located in the inspected Mathlib sources |
| Structure of a bounded candidate | The correlation estimate and a van der Corput argument give Proposition 1.11 | General analytic foundations | Quantitative estimates and probability bounds are unformalized here |
| Structured-case contradiction | Section 4's generalized Borwein–Choi–Coons argument | General arithmetic/analysis foundations | The complete contradiction is unformalized here |

The relevant exact Mathlib files inspected at revision `0df444a360eaa60ab8c11dca51a86af692955474` are:

- `Mathlib/Analysis/Fourier/FiniteAbelian/Orthogonality.lean`: character orthogonality and linear independence.
- `Mathlib/MeasureTheory/Measure/Prokhorov.lean`: includes a `CompactSpace (ProbabilityMeasure E)` instance for compact metrizable `E`.
- `Mathlib/NumberTheory/DirichletCharacter/Bounds.lean`: includes `norm_le_one`.

These foundations do not themselves imply the missing number-theoretic estimates. Text searches for Elliott, Chowla, pretentiousness, Halász, and Kátai found no matching needed analytic theorem; this is a statement about the inspected sources, not a proof of global absence.

The correlation input comes from Tao, *The logarithmically averaged Chowla and Elliott conjectures for two-point correlations*, [arXiv:1509.05422](https://arxiv.org/abs/1509.05422), Theorem 1.3. It involves additional deep mean-value and entropy arguments. Assuming it as a new axiom would not provide the requested complete proof.

## Quadratic-certificate route

An independent agent audited the distinct route in Tao's Remark 1.12. A finite sufficient certificate for a threshold B consists of:

1. A finite horizon N and nonnegative weights λ on homogeneous arithmetic progressions P within {1,…,N}.
2. Nonnegative diagonal weights b_i such that M = Σ_P λ_P 1_P 1_Pᵀ − diag(b) is positive semidefinite.
3. The strict bound Σ_i b_i > B² Σ_P λ_P.

For a sign vector x, positivity of M and x_i² = 1 imply Σ_P λ_P (Σ_{i∈P} x_i)² ≥ Σ_i b_i. If every progression sum had absolute value at most B, the left side would be at most B² Σ_P λ_P, a contradiction.

This argument explains how a certificate would prove a finite bound. The missing full-proof node is constructing and proving valid certificates for **every** B. An individual numerical certificate or search program does not establish that quantifier. Tao records abstract existence through the full theorem but does not give an explicit family in Remark 1.12; treating that existence as an input would conceal the original proof obligation.

## Submission status

The new `discrepancyStatement_iff_uniformFiniteStatement` dependency identifies the exact finite target without assuming its truth. It has passed independent mathematical review: compactness gives a finite cover, then the largest endpoint d*m supplies a horizon chosen independently of the sequence. Local compilation of the root declarations together with this proof succeeded with exit 0 and no warnings. Both new equivalences depend only on `[propext, Classical.choice, Quot.sound]`. The clean module build and axiom checks also run in GitHub CI.

There is no complete candidate `Solution.lean`. No full Palomar mechanical preflight or intake has been performed. The successful repository CI verifies only the declarations actually implemented. The full original target has not changed.
