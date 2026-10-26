module ConvexityInvariant

export convexity_score, convexity_invariant

using LinearAlgebra
using ..Manifold80D
using ..A7_Spectral
using ..CurvatureEnvelope
using ..HolonomyField
using ..TopologyOperator
using ..FusionOperator

# ============================================================
#  Convexity Score
# ============================================================

"""
    convexity_score(e, M)

Computes a convexity score for an embedded frontier vector e ∈ ℝ⁸⁰.

Score combines:
- spectral energy
- curvature energy
- holonomy energy
- topology energy

Formula:
    V = α Es + β Ec + γ Eh + δ Et

Altitude: A8.
"""
function convexity_score(e::Vector{Float64}, M::Manifold80D.SoftManifold80D)
    if length(e) != M.dim
        error("Convexity score error: vector dimension mismatch.")
    end

    # Spectral energy
    Es = A7_Spectral.spectral_energy(e, M)

    # Curvature energy
    Ec = CurvatureEnvelope.curvature_energy(e, M)

    # Holonomy energy
    Eh = HolonomyField.holonomy_energy(e, M)

    # Topology energy
    Et = TopologyOperator.topology_energy(e, M)

    # Equal weights
    α = 0.25
    β = 0.25
    γ = 0.25
    δ = 0.25

    return α*Es + β*Ec + γ*Eh + δ*Et
end


# ============================================================
#  Convexity Invariant
# ============================================================

"""
    convexity_invariant(e, M)

Computes the full convexity invariant:

    I_convex = Φ(e) * V

where:
- Φ(e) is fusion energy
- V is convexity score

Altitude: A8 → A3.
"""
function convexity_invariant(e::Vector{Float64}, M::Manifold80D.SoftManifold80D)
    V = convexity_score(e, M)
    Φ = FusionOperator.fusion_energy(e, M)
    return Φ * V
end

end # module
