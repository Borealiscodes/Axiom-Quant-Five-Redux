module CanonicalFormInvariant

export canonical_score, canonical_invariant

using LinearAlgebra
using ..Manifold80D
using ..A7_Spectral
using ..CurvatureEnvelope
using ..HolonomyField
using ..TopologyOperator
using ..FusionOperator
using ..ConnectivityInvariant
using ..QuantizationInvariant
using ..ConvexityInvariant

# ============================================================
#  Canonical Score
# ============================================================

"""
    canonical_score(e, M)

Computes a canonical-form score for an embedded vector e ∈ ℝ⁸⁰.

Score combines:
- spectral energy
- curvature energy
- holonomy energy
- topology energy
- connectivity invariant
- quantization invariant
- convexity invariant

Formula:
    S = α Es + β Ec + γ Eh + δ Et
        + ε I_conn + ζ I_quant + η I_convex

Altitude: A8.
"""
function canonical_score(e::Vector{Float64}, M::Manifold80D.SoftManifold80D)
    if length(e) != M.dim
        error("Canonical score error: vector dimension mismatch.")
    end

    # Base geometric energies
    Es = A7_Spectral.spectral_energy(e, M)
    Ec = CurvatureEnvelope.curvature_energy(e, M)
    Eh = HolonomyField.holonomy_energy(e, M)
    Et = TopologyOperator.topology_energy(e, M)

    # Invariant energies
    I_conn   = ConnectivityInvariant.connectivity_invariant(e, M)
    I_quant  = QuantizationInvariant.quantization_invariant(e, M)
    I_convex = ConvexityInvariant.convexity_invariant(e, M)

    # Weights
    α = 0.15
    β = 0.15
    γ = 0.15
    δ = 0.15
    ε = 0.1333
    ζ = 0.1333
    η = 0.1333

    return α*Es + β*Ec + γ*Eh + δ*Et +
           ε*I_conn + ζ*I_quant + η*I_convex
end


# ============================================================
#  Canonical-Form Invariant
# ============================================================

"""
    canonical_invariant(e, M)

Computes the full canonical-form invariant:

    I_canon = Φ(e) * S

where:
- Φ(e) is fusion energy
- S is canonical score

Altitude: A8 → A2.
"""
function canonical_invariant(e::Vector{Float64}, M::Manifold80D.SoftManifold80D)
    S = canonical_score(e, M)
    Φ = FusionOperator.fusion_energy(e, M)
    return Φ * S
end

end # module
