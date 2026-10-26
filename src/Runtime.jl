module Runtime

export ReduxRuntime, evaluate_geometry, evaluate_all_invariants

using LinearAlgebra

# Core manifold
using ..Manifold80D

# Operators
using ..A7_Spectral
using ..CurvatureEnvelope
using ..HolonomyField
using ..TopologyOperator
using ..FusionOperator

# Domains
using ..ErdosGraph
using ..BitNetTernary
using ..MarkowitzFrontier
using ..BlackScholesVol
using ..RenyiEntropy

# Invariants
using ..ConnectivityInvariant
using ..QuantizationInvariant
using ..ConvexityInvariant
using ..CanonicalFormInvariant
using ..EntropyShiftInvariant

# ============================================================
#  Runtime Structure
# ============================================================

"""
    ReduxRuntime()

Constructs a full Redux runtime with:
- soft manifold
- operator suite
- domain modules
- invariant suite

Altitude: A1.
"""
struct ReduxRuntime
    manifold::Manifold80D.SoftManifold80D
end


# ============================================================
#  Geometry Evaluation
# ============================================================

"""
    evaluate_geometry(rt, domain_vector)

Runs the full operator stack on a domain vector.

Steps:
1. Spectral projection
2. Curvature modulation
3. Holonomy transport
4. Topology modulation
5. Fusion geometry

Returns:
- fused geometry vector F ∈ ℝ⁸⁰

Altitude: A1.
"""
function evaluate_geometry(rt::ReduxRuntime, v::Vector{Float64})
    M = rt.manifold

    # Spectral projection
    λ, U = A7_Spectral.spectral_decomposition(M)
    s = U' * v

    # Curvature modulation
    κ = CurvatureEnvelope.compute_curvature_envelope(M)
    c = s .* (1 .+ 0.1 .* κ)

    # Holonomy transport
    h = HolonomyField.holonomy_transport(c, M)

    # Topology modulation
    τ = TopologyOperator.compute_topology_signature(M)
    t = h .* (1 .+ 0.05 .* τ)

    # Fusion geometry
    F = FusionOperator.fused_geometry(t, M)

    return F
end


# ============================================================
#  Invariant Evaluation
# ============================================================

"""
    evaluate_all_invariants(rt, F)

Computes all invariants on fused geometry F.

Returns NamedTuple:
- connectivity
- quantization
- convexity
- canonical_form
- entropy_shift

Altitude: A1.
"""
function evaluate_all_invariants(rt::ReduxRuntime, F::Vector{Float64})
    M = rt.manifold

    return (
        connectivity     = ConnectivityInvariant.connectivity_invariant(F, M),
        quantization     = QuantizationInvariant.quantization_invariant(F, M),
        convexity        = ConvexityInvariant.convexity_invariant(F, M),
        canonical_form   = CanonicalFormInvariant.canonical_invariant(F, M),
        entropy_shift    = EntropyShiftInvariant.entropy_shift_invariant(F, M)
    )
end

end # module
