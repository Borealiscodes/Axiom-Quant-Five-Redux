module InvariantSuite

using ..ConnectivityInvariant
using ..QuantizationInvariant
using ..ConvexityInvariant
using ..CanonicalFormInvariant
using ..EntropyShiftInvariant
using ..Manifold80D

export InvariantSuiteState, compute_invariant_suite

"""
    InvariantSuiteState

Aggregates all invariants into a unified structure.
Stores:
- connectivity invariant
- quantization invariant
- convexity invariant
- canonical-form invariant
- entropy-shift invariant
- combined score (placeholder)
"""
struct InvariantSuiteState
    connectivity::ConnectivityInvariant.ConnectivityInvariantState
    quantization::QuantizationInvariant.QuantizationInvariantState
    convexity::ConvexityInvariant.ConvexityInvariantState
    canonical_form::CanonicalFormInvariant.CanonicalFormInvariantState
    entropy_shift::EntropyShiftInvariant.EntropyShiftInvariantState
    combined_score::Float64
end


"""
    compute_invariant_suite(domains, M)

Computes all invariants for the given domain states and aggregates them.
`domains` is a NamedTuple containing:
- G  = ErdosGraphState
- B  = BitNetState
- MK = MarkowitzState
- BS = BlackScholesState
- R  = RenyiState

Altitude: full invariant span (A3 → A8).
"""
function compute_invariant_suite(domains::NamedTuple, M::Manifold80D.SoftManifold80D)

    conn = ConnectivityInvariant.compute_connectivity_invariant(domains.G, M)
    quant = QuantizationInvariant.compute_quantization_invariant(domains.B, M)
    conv = ConvexityInvariant.compute_convexity_invariant(domains.MK, M)
    canon = CanonicalFormInvariant.compute_canonical_form_invariant(domains.BS, M)
    entr = EntropyShiftInvariant.compute_entropy_shift_invariant(domains.R, M)

    # Placeholder combined score: weighted sum of invariant norms
    combined = conn.invariant +
               quant.invariant +
               conv.invariant +
               canon.invariant +
               entr.invariant

    return InvariantSuiteState(conn, quant, conv, canon, entr, combined)
end

end # module
