module MarkowitzFrontier

export compute_frontier, embed_frontier_geometry

using LinearAlgebra
using ..Manifold80D
using ..A7_Spectral
using ..CurvatureEnvelope
using ..HolonomyField
using ..TopologyOperator

# ============================================================
#  Markowitz Frontier Computation
# ============================================================

"""
    compute_frontier(returns, cov)

Computes the Markowitz efficient frontier for a set of assets.

Inputs:
- returns: μ ∈ ℝᵏ
- cov: Σ ∈ ℝᵏˣᵏ (covariance matrix)

Outputs:
- weights w ∈ ℝᵏ (minimum-variance portfolio)
- risk σ
- mean μ̄

Altitude: A4.
"""
function compute_frontier(returns::Vector{Float64}, cov::Matrix{Float64})
    k = length(returns)

    # Solve minimum-variance portfolio:
    #   minimize wᵀ Σ w  subject to ∑ wᵢ = 1
    ones_vec = ones(Float64, k)
    Σ_inv = inv(cov)

    numerator = Σ_inv * ones_vec
    denominator = dot(ones_vec, numerator)

    w = numerator ./ denominator

    # Portfolio risk and mean
    σ = sqrt(w' * cov * w)
    μ̄ = dot(w, returns)

    return (weights=w, risk=σ, mean=μ̄, k=k)
end


# ============================================================
#  Frontier → Manifold Embedding
# ============================================================

"""
    embed_frontier_geometry(frontier, M)

Embeds the Markowitz frontier geometry into the 80D soft manifold.

Steps:
1. Construct convexity vector c ∈ ℝᵏ
2. Pad to 80D
3. Spectral projection
4. Curvature modulation
5. Holonomy transport
6. Topology modulation

Returns:
- embedded vector e ∈ ℝ⁸⁰

Altitude: A5 → A7 → A8.
"""
function embed_frontier_geometry(frontier::NamedTuple, M::Manifold80D.SoftManifold80D)
    k = frontier.k
    w = frontier.weights
    σ = frontier.risk
    μ̄ = frontier.mean

    # Step 1: Construct convexity vector
    # Convexity proxy: combine weights, risk, and mean
    c = zeros(Float64, M.dim)
    scale_w = 1 / (1 + maximum(abs.(w)))

    for i in 1:k
        c[i] = w[i] * scale_w
    end

    # Encode risk and mean into slack dimensions
    c[end-1] = σ / (1 + σ)
    c[end]   = μ̄ / (1 + abs(μ̄))

    # Step 2: Spectral projection
    λ, U = A7_Spectral.spectral_decomposition(M)
    s = U' * c

    # Step 3: Curvature modulation
    κ = CurvatureEnvelope.compute_curvature_envelope(M)
    curv_mod = s .* (1 .+ 0.1 .* κ)

    # Step 4: Holonomy transport
    h = HolonomyField.holonomy_transport(curv_mod, M)

    # Step 5: Topology modulation
    τ = TopologyOperator.compute_topology_signature(M)
    e = h .* (1 .+ 0.05 .* τ)

    return e
end

end # module
