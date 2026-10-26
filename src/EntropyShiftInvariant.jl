module EntropyShiftInvariant

export entropy_shift_score, entropy_shift_invariant

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
using ..CanonicalFormInvariant

# ============================================================
#  Entropy-Shift Score
# ============================================================

"""
    entropy_shift_score(e, M)

Computes an entropy-shift score for an embedded entropy vector e ∈ ℝ⁸⁰.

Score combines:
- spectral energy
- curvature energy
- holonomy energy
- topology energy
- connectivity invariant
- quantization invariant
- convexity invariant
- canonical-form invariant

Formula:
    E = α Es + β Ec + γ Eh + δ Et
        + ε I_conn + ζ I_quant + η I_convex + θ I_canon

Altitude: A8.
"""
function entropy_shift_score(e::Vector{Float64}, M::Manifold80D.SoftManifold80D)
    if length(e) != M.dim
        error("Entropy-shift score error: vector dimension mismatch.")
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
    I_canon  = CanonicalFormInvariant.canonical_invariant(e, M)

    # Weights
    α = 0.125
    β = 0.125
    γ = 0.125
    δ = 0.125
    ε = 0.125
    ζ = 0.125
    η = 0.125
    θ = 0.125

    return α*Es + β*Ec + γ*Eh + δ*Et +
           ε*I_conn + ζ*I_quant + η*I_convex + θ*I_canon
end


# ============================================================
#  Entropy-Shift Invariant
# ============================================================

"""
    entropy_shift_invariant(e, M)

Computes the full entropy-shift invariant:

    I_shift = Φ(e) * E

where:
- Φ(e) is fusion energy
- E is entropy-shift score

Altitude: A8 → A1.
"""
function entropy_shift_invariant(e::Vector{Float64}, M::Manifold80D.SoftManifold80D)
    E = entropy_shift_score(e, M)
    Φ = FusionOperator.fusion_energy(e, M)
    return Φ * E
end

end # module
