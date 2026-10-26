module FusionOperator

export fused_geometry, fusion_energy

using LinearAlgebra
using ..Manifold80D
using ..A7_Spectral
using ..CurvatureEnvelope
using ..HolonomyField
using ..TopologyOperator

# ============================================================
#  Fused Geometry Vector
# ============================================================

"""
    fused_geometry(v, M)

Computes a fused geometry vector F ∈ ℝ⁸⁰ combining:

- spectral coefficients
- curvature envelope
- holonomy connection form
- topology signature

Fusion rule (altitude-safe):

    Fᵢ = α sᵢ + β κᵢ + γ ωᵢ + δ τᵢ

with default weights:
    α = 0.25
    β = 0.25
    γ = 0.25
    δ = 0.25

Altitude: A7/A8.
"""
function fused_geometry(v::Vector{Float64}, M::Manifold80D.SoftManifold80D)
    if length(v) != M.dim
        error("Fusion error: vector dimension mismatch.")
    end

    # Spectral coefficients
    λ, U = A7_Spectral.spectral_decomposition(M)
    s = U' * v

    # Curvature envelope
    κ = CurvatureEnvelope.compute_curvature_envelope(M)

    # Holonomy connection form
    ω = HolonomyField.compute_connection_form(M)

    # Topology signature
    τ = TopologyOperator.compute_topology_signature(M)

    # Fusion weights
    α = 0.25
    β = 0.25
    γ = 0.25
    δ = 0.25

    # Fused geometry
    F = α .* s .+ β .* κ .+ γ .* ω .+ δ .* τ

    return F
end


# ============================================================
#  Fusion Energy
# ============================================================

"""
    fusion_energy(v, M)

Computes fusion energy:

    Φ(v) = ∑ Fᵢ vᵢ²

where F is the fused geometry vector.

Altitude: A7/A8.
"""
function fusion_energy(v::Vector{Float64}, M::Manifold80D.SoftManifold80D)
    F = fused_geometry(v, M)
    return sum(F .* (v .^ 2))
end

end # module
