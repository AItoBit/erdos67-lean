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

## Research round: fixed bound and analytic reuse candidate

The theorem `Erdos67.discrepancy_one_at_twelve` is proved in `Erdos67/FiniteBound.lean`. It establishes the finite target at B=1 with N=12. The actual module compiled with exit 0, the axiom check reported only `[propext, Classical.choice, Quot.sound]`, and an independent AI agent's mathematical audit passed. Two exact integer computations independently confirmed the finite counts: no length-12 assignment stays within discrepancy 1, while exactly four length-11 assignments do. These are sanity checks for the full development, with no assertion that a finite list of thresholds proves unboundedness.

A new source candidate was located at [openai/math, commit fd4aeeb2ee4fc729c18d98444fed42fd0529eeeb](https://github.com/openai/math/tree/fd4aeeb2ee4fc729c18d98444fed42fd0529eeeb). Its Comparator configuration names `OAI.NumberTheory.OrdinaryCorrelations.Elliott.Main` as the solution module. The actual [BinaryCorrectedElliott proof](https://github.com/openai/math/blob/fd4aeeb2ee4fc729c18d98444fed42fd0529eeeb/lean/OAI/NumberTheory/OrdinaryCorrelations/Elliott/BinaryCorrectedElliott.lean) invokes `ElliottCompletion.anchored`. The inspected immediate proof files contain no local proof holes or new axioms. Its large dependency closure has not been independently compiled or axiom-checked here, and the candidate has not been imported into this development.

Its [exact interface](https://github.com/openai/math/blob/fd4aeeb2ee4fc729c18d98444fed42fd0529eeeb/lean/ComparatorChallenges/OrdinaryElliott.lean) fixes two multiplicative functions, assumes asymptotic uniform nonpretentiousness of at least one, and concludes a limit of ordinary shifted correlations. That does not directly give an estimate uniform over functions varying with the scale. This quantifier issue remains even if the candidate passes its kernel audit.

A follow-up audit of its immediate quantitative lemmas did not close that gap. `AnalyticCentering` and `OrdinaryShortPowerLogarithmic` still assume full nonpretentiousness of fixed functions, with scale cutoffs depending on them. The separate [MRTShortTheorem](https://github.com/openai/math/blob/fd4aeeb2ee4fc729c18d98444fed42fd0529eeeb/lean/OAI/NumberTheory/TwoPoint/ShortIntervals/MRTShortTheorem.lean) derives a uniform short-interval estimate from explicit `HalaszPrimeSparseInput` and `HalaszHighPrimeInput` hypotheses. The inspected modules do not discharge those inputs unconditionally. This is a scoped source audit, not a claim about every module in that repository.

An independent mathematical bridge review obtained the following conditional consequence. Suppose a stochastic unit-valued completely multiplicative function has all partial-sum second moments at most C², and suppose the candidate correlation theorem is available. Let A be the event of uniform nonpretentiousness and average the squared modulus of length-H blocks over their starting positions. The expected block energy is at most 4C². On A its limit is H, by expanding the square and applying correlation cancellation. Fatou gives H·P(A) ≤ 4C² for every H, hence P(A)=0. This argument has not been implemented in Lean.

The exceptional branch remains. Failure of uniform nonpretentiousness gives a character and a bounded distance at infinitely many sample-dependent scales, with a potentially changing frequency. It does not by itself give a uniform bound at every sufficiently large scale or a high-probability event there. For a concrete quantifier countermodel, enumerate the k equal subintervals of [0,1) in each successive block k: every point belongs to infinitely many events, but their probabilities tend to zero. The missing uniform-scale bridge, Fourier reduction, and structured-case contradiction still prevent a complete proof.

The machine-readable `research/knowledge-graph.json` distinguishes these conditional arguments and unverified sources from kernel-checked results. The full target remains unchanged.

## Submission status

The new `discrepancyStatement_iff_uniformFiniteStatement` dependency identifies the exact finite target without assuming its truth. It has passed independent mathematical review: compactness gives a finite cover, then the largest endpoint d*m supplies a horizon chosen independently of the sequence. Local compilation of the root declarations together with this proof succeeded with exit 0 and no warnings. Both new equivalences depend only on `[propext, Classical.choice, Quot.sound]`. The clean module build and axiom checks also run in GitHub CI.

There is no complete candidate `Solution.lean`. No full Palomar mechanical preflight or intake has been performed. The successful repository CI verifies only the declarations actually implemented. The full original target has not changed.
