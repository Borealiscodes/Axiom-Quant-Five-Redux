module TopologyOperator

export compute_topology_signature, topology_roughness, topology_energy

using LinearAlgebra
using ..Manifold80D

# ============================================================
#  Topology Signature
# ============================================================

"""
    compute_topology_signature(M)

Computes a topology signature τ ∈ ℝ⁸⁰ that encodes
global structural variation in the manifold.

Uses:
- sign changes in curvature envelope
- normalized metric variation
- slack-dimension modulation

Altitude: A7.
"""
function compute_topology_signature(M::Manifold80D.SoftManifold80D)
    dim = M.dim
    κ = M.curvature
    diag_metric = diag(M.metric)

    τ = zeros(Float64, dim)

    # Sign-change detector for curvature
    for i in 2:dim
        τ[i] = sign(κ[i] - κ[i-1])
    end

    # Add normalized metric variation
    Δg = diff(diag_metric)
    Δg_norm = Δg ./ (1 .+ abs.(Δg))

    for i in 1:(dim-1)
        τ[i] += 0.5 * Δg_norm[i]
    end

    # Slack modulation
    τ .= τ .* M.slack_mask

    return τ
end


# ============================================================
#  Topology Roughness
# ============================================================

"""
    topology_roughness(M)

Computes a scalar roughness measure R(M):

    R = ∑ |τᵢ|

where τ is the topology signature.

Altitude: A7.
"""
function topology_roughness(M::Manifold80D.SoftManifold80D)
    τ = compute_topology_signature(M)
    return sum(abs.(τ))
end


# ============================================================
#  Topology Energy
# ============================================================

"""
    topology_energy(v, M)

Computes topology energy:

    T(v) = ∑ τᵢ vᵢ²

where τ is the topology signature.

Altitude: A7.
"""
function topology_energy(v::Vector{Float64}, M::Manifold80D.SoftManifold80D)
    if length(v) != M.dim
        error("Topology energy error: vector dimension mismatch.")
    end

    τ = compute_topology_signature(M)
    return sum(τ .* (v .^ 2))
end

end # module
