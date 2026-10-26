module QuantizationInvariant

export quantization_score, quantization_invariant

using LinearAlgebra
using ..Manifold80D
using ..A7_Spectral
using ..CurvatureEnvelope
using ..HolonomyField
using ..TopologyOperator
using ..FusionOperator

# ============================================================
#  Quantization Score
# ============================================================

"""
    quantization_score(e, M)

Computes a quantization score for an embedded ternary vector e ∈ ℝ⁸⁰.

Score combines:
- spectral energy
- curvature energy
- holonomy energy
- topology energy

Formula:
    Q = α Es + β Ec + γ Eh + δ Et

Altitude: A8.
"""
function quantization_score(e::Vector{Float64}, M::Manifold80D.SoftManifold80D)
    if length(e) != M.dim
        error("Quantization score error: vector dimension mismatch.")
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
#  Quantization Invariant
# ============================================================

"""
    quantization_invariant(e, M)

Computes the full quantization invariant:

    I_quant = Φ(e) * Q

where:
- Φ(e) is fusion energy
- Q is quantization score

Altitude: A8 → A3.
"""
function quantization_invariant(e::Vector{Float64}, M::Manifold80D.SoftManifold80D)
    Q = quantization_score(e, M)
    Φ = FusionOperator.fusion_energy(e, M)
    return Φ * Q
end

end # module
