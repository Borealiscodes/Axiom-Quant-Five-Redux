module ConnectivityInvariant

export connectivity_score, connectivity_invariant

using LinearAlgebra
using ..Manifold80D
using ..A7_Spectral
using ..CurvatureEnvelope
using ..HolonomyField
using ..TopologyOperator
using ..FusionOperator

# ============================================================
#  Connectivity Score
# ============================================================

"""
    connectivity_score(e, M)

Computes a connectivity score for an embedded graph vector e ∈ ℝ⁸⁰.

Score combines:
- spectral energy
- curvature energy
- holonomy energy
- topology energy

Formula:
    C = α Es + β Ec + γ Eh + δ Et

Altitude: A8.
"""
function connectivity_score(e::Vector{Float64}, M::Manifold80D.SoftManifold80D)
    if length(e) != M.dim
        error("Connectivity score error: vector dimension mismatch.")
    end

    # Spectral energy
    Es = A7_Spectral.spectral_energy(e, M)

    # Curvature energy
    Ec = CurvatureEnvelope.curvature_energy(e, M)

    # Holonomy energy
    Eh = HolonomyField.holonomy_energy(e, M)

    # Topology energy
    Et = TopologyOperator.topology_energy(e, M)

    # Weights
    α = 0.25
    β = 0.25
    γ = 0.25
    δ = 0.25

    return α*Es + β*Ec + γ*Eh + δ*Et
end


# ============================================================
#  Connectivity Invariant
# ============================================================

"""
    connectivity_invariant(e, M)

Computes the full connectivity invariant:

    I_conn = Φ(e) * C

where:
- Φ(e) is fusion energy
- C is connectivity score

Altitude: A8 → A3.
"""
function connectivity_invariant(e::Vector{Float64}, M::Manifold80D.SoftManifold80D)
    C = connectivity_score(e, M)
    Φ = FusionOperator.fusion_energy(e, M)
    return Φ * C
end

end # module
