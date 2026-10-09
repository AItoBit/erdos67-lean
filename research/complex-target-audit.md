# Real and complex target audit — 2026-10-09

Status: **INCOMPLETE**. Neither full discrepancy statement has been proved in this development. Tao proved the mathematical theorem; the missing result here is its Lean formalization.

Later packaging update on the same date: a separate, explicitly partial-result Challenge/Solution pair is now provided. The historical submission remarks below describe the full-theorem target, not the smaller package. Current scope and verification links are in README.md.

## Source and exact scope

The user supplied the two statements from Formal Conjectures and a two-page printout `C:/Users/Usuario/Downloads/67palomar.pdf`. The attachment is a problem-page printout, not a proof manuscript. The reference link in the pasted code has label `/67` but destination `/66`; the correct problem is [67](https://www.erdosproblems.com/67).

Primary sources checked: Tao, *The Erdős discrepancy problem*, [Discrete Analysis 2016:1](https://discreteanalysisjournal.com/article/609-the-erdos-discrepancy-problem), and [arXiv v6](https://arxiv.org/html/1509.05363v6). The paper's Theorem 1.1 gives the Hilbert-space version and Corollary 1.2 gives the real sign version. The supplied complex sphere statement is a specialization of the Hilbert-space theorem.

The inspected [Formal Conjectures source](https://github.com/google-deepmind/formal-conjectures/blob/87d97fa7626c7b39ee4c8565d3acfa5a048d6cae/FormalConjectures/ErdosProblems/67.lean) still has `sorry` for both statements. This is not evidence that no formal proof exists elsewhere.

| Source clause | Formal representation | Fidelity |
|---|---|---|
| Arbitrary sign sequence | `ℕ → ({-1, 1} : Finset ℝ)` | No multiplicativity assumption |
| Complex unit sequence | `ℕ → Metric.sphere (0 : ℂ) 1` | Each value has norm one |
| Every positive real threshold | `∀ C : ℝ, 0 < C → …` | No fixed bound substitutes for this quantifier |
| Positive step and length | `1 ≤ d ∧ 1 ≤ m` | Both witnesses may depend on sequence and threshold |
| Homogeneous progression | `∑ k ∈ Finset.Icc 1 m, f (k * d)` | Includes both endpoints; index zero is unused |
| Strict discrepancy | Real absolute value / complex norm `> C` | No weakening to a non-strict inequality |

The printout displays a different endpoint convention. The exact targets here follow the user's supplied Lean statements and the primary theorem; the attachment is not treated as an instruction to change those targets. No assertion about a single fixed step having unbounded sums is made: that is stronger and does not follow.

## Proof obligations

The checked integer-sign formulation and finite-horizon equivalence are useful representations of the real target. They do not prove it. The endpoint-12 theorem handles only threshold 1.

A complex-to-real bridge uses the isometric embedding of real numbers into complex numbers, compatibility with finite sums, and the norm of a real complex number. It assumes the full complex target; it does not establish that target. An equivalence with integer signs changes the representation, not the mathematical strength.

The substantive missing dependencies remain the Fourier reduction to stochastic completely multiplicative functions, the required logarithmically averaged correlation estimate with its uniform quantifiers, the structural/probability argument, and the structured multiplicative contradiction. Their status and alternative certificate route are recorded in [PROOF_STATUS.md](../PROOF_STATUS.md).

## Submission decision

Local verification passed on Lean 4.35.0-rc2 and Mathlib `065356127b1dc0016f66b7283ce0ce2c4055aa55`: all four modules built without warnings, and all six inspected theorems depend only on `propext`, `Classical.choice`, and `Quot.sound`. The new bridges passed an independent mathematical audit. Exact evidence is in [verification/complex-audit.txt](../verification/complex-audit.txt). This verifies the bridges, not either full target.

[Palomar requires](https://palomar-registry.org/how-to-submit) an actual proved Solution matching the Challenge, with permitted axiom dependencies. A placeholder, a theorem assuming the full discrepancy statement, or the fixed bound at 12 would not satisfy the requested full proof. No full Solution, Comparator preflight, or submission is claimed for Erdős 67. No submission status link exists for this new result.

This local checkout is based on `AItoBit/erdos67-lean` commit `7a8f698fb9e5ea525386a9130b8e379c703936ee`, branch `codex/erdos67-complex-audit`. It preserves the existing Apache 2.0 license. New changes have not been pushed as a completed formalization.
