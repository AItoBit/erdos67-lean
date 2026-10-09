"""Two exhaustive integer checks of discrepancy <= 1 at lengths 11 and 12.

These computations are evidence. The separate Lean proof is the proof artifact.
No sampling, floating point, randomness, SAT solver, or external package is used.
"""

from collections import Counter
from itertools import product
import json


def direct_enumeration(n):
    histogram = Counter()
    bounded = []
    for signs in product((-1, 1), repeat=n):
        discrepancy = max(
            abs(sum(signs[d * k - 1] for k in range(1, m + 1)))
            for d in range(1, n + 1)
            for m in range(1, n // d + 1)
        )
        histogram[discrepancy] += 1
        if discrepancy <= 1:
            bounded.append(list(signs))
    assert sum(histogram.values()) == 2**n
    return {
        "assignments_checked": 2**n,
        "discrepancy_histogram": dict(sorted(histogram.items())),
        "bounded_sequences": bounded,
    }


def independent_prefix_search(n):
    # A different exhaustive algorithm: extend prefixes, checking only the
    # newly completed HAP sums. Prune a branch only after an exact violation.
    prefixes = [[]]
    layer_sizes = [1]
    for endpoint in range(1, n + 1):
        next_prefixes = []
        for prefix in prefixes:
            for bit in (0, 1):
                candidate = prefix + [bit]
                valid = True
                for stride in range(1, endpoint + 1):
                    if endpoint % stride != 0:
                        continue
                    total = 0
                    position = stride
                    while position <= endpoint:
                        total += 2 * candidate[position - 1] - 1
                        position += stride
                    if total < -1 or total > 1:
                        valid = False
                        break
                if valid:
                    next_prefixes.append(candidate)
        prefixes = next_prefixes
        layer_sizes.append(len(prefixes))
    return {
        "surviving_prefixes_by_length": layer_sizes,
        "bounded_sequences": [[2 * bit - 1 for bit in bits] for bits in prefixes],
    }


results = {}
for n in (11, 12):
    direct = direct_enumeration(n)
    independent = independent_prefix_search(n)
    assert sorted(direct["bounded_sequences"]) == sorted(independent["bounded_sequences"])
    results[str(n)] = {"direct": direct, "independent": independent}

assert results["11"]["direct"]["bounded_sequences"]
assert not results["12"]["direct"]["bounded_sequences"]
print(json.dumps({"arithmetic": "exact integers", "results": results}, indent=2))
