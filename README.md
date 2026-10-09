# Erdős Problem 67 — incomplete Lean development

**This repository does not prove the Erdős discrepancy theorem and is not ready for Palomar submission.**

`Erdos67.lean` defines the exact arbitrary-sign-sequence, unbounded homogeneous arithmetic progression discrepancy statement. It proves that restricting the thresholds to natural numbers is equivalent to using all positive real thresholds. That equivalence proves neither discrepancy assertion. There is no `Solution.lean` proving the full problem.

`Erdos67/Compactness.lean` supplies the next exact reduction: for every bound B there is a finite horizon N that works for every sign sequence if and only if the original theorem holds. The horizon is selected before the sequence, using a finite subcover of the compact sign-sequence space. This equivalence leaves the existence of those finite bounds unproved. See [the dependency audit](PROOF_STATUS.md) for the remaining full-proof obligations.

`Erdos67/FiniteBound.lean` proves that every sign sequence has a homogeneous progression ending at or before 12 with absolute sum greater than 1. Its proof uses nine progression constraints and integer arithmetic. This is only the threshold B=1, not the full unbounded-discrepancy theorem. Two separate exact algorithms in `research/exhaustive_bound_one.py` also enumerate all 4,096 length-12 assignments and all 2,048 length-11 assignments; their results agree, with four surviving assignments at length 11 and none at length 12. The computation is recorded separately from the Lean proof.

The research graph in `research/knowledge-graph.json` records proved reductions, exact computations, remaining proof obligations, and rejected shortcuts. Evidence for a fixed threshold is never promoted to a proof for every threshold.

## Mathematical source

The full mathematical result is Terence Tao, *The Erdős discrepancy problem*, Discrete Analysis 2016:1, DOI 10.19086/da.609, Corollary 1.2 ([arXiv](https://arxiv.org/html/1509.05363v6)). The target is also recorded at [Erdős Problem 67](https://www.erdosproblems.com/67). No claim of mathematical novelty is made.

## Verification

- Lean 4.33.1.
- Mathlib revision `0df444a360eaa60ab8c11dca51a86af692955474`, with transitive dependency commits in `lake-manifest.json`.
- Local elaboration of the identical `Erdos67.lean` succeeded with exit 0 and no diagnostics in an existing checkout using those pins.
- The threshold equivalence passed an independent AI agent's mathematical and source-fidelity audit. This is not human expert review.
- Local `#print axioms` reported `[propext, Classical.choice, Quot.sound]` for the equivalence. The output is in `verification/axioms.txt`.
- The compactness equivalences also compiled locally with those three axiom dependencies and passed a separate AI agent's mathematical review.
- The finite bound at length 12 compiled locally with those same three axiom dependencies and passed an independent AI agent's mathematical review; evidence is in `verification/finite-bound-result.txt`.
- The development has no proof holes, custom mathematical axioms, or `native_decide`. The full target remains an unproved proposition definition.
- GitHub CI builds this standalone package and prints the implemented theorems' axiom dependencies. Its result must be checked separately; local verification does not imply CI success.

Reproduce:

```sh
lake exe cache get
lake build Erdos67 Erdos67.Compactness Erdos67.FiniteBound
lake env lean CheckAxioms.lean
```

## Proof gap and Palomar readiness

Tao's route uses a Fourier reduction to stochastic completely multiplicative functions, a logarithmically averaged Elliott theorem, and analysis of the structured multiplicative case. These proof dependencies have not been formalized here.

A fixed-function ordinary Elliott proof candidate was located in [openai/math at fd4aeeb2ee4fc729c18d98444fed42fd0529eeeb](https://github.com/openai/math/tree/fd4aeeb2ee4fc729c18d98444fed42fd0529eeeb). Its full dependency closure is unverified here, and its asymptotic interface does not directly supply the uniform finite-scale input needed by Tao's argument. The dependency audit records the precise remaining bridge; this candidate is not a checked dependency of our package.

Public candidates inspected at `primaryhosting/brockian-mathematics` revision `29426ff65b6f1fd68d594e529632eb79b5be3089` establish only a finite discrepancy lower bound of 2 or logical equivalences. Their arbitrary-threshold claims are definitions or explicit hypotheses; no complete proof was recovered or copied.

[Palomar requires](https://palomar-registry.org/how-to-submit) a proved Solution matching a readable Challenge, a Comparator configuration, provenance metadata, a supported pinned toolchain, and a passing complete mechanical preflight before intake. This research package does not meet those requirements: the full proof is missing, the current verified toolchain predates the documented minimum, and no Comparator package or Palomar preflight is claimed. Creating placeholders for the missing proof would not repair eligibility.

No Palomar submission or registration has been initiated. The next substantive task is proving the full frozen target and its prerequisites; packaging and supported-toolchain migration follow that work.

## Provenance

Prepared with AI assistance at the user's request. Source fidelity and the threshold reduction were independently reviewed by another AI agent. Authorship or human review of Tao's proof is not claimed. Mathlib and this repository use the Apache 2.0 license.
