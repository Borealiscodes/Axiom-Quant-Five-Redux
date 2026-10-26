module RenyiEntropy

export compute_renyi_entropy, embed_entropy_geometry

using LinearAlgebra
using ..Manifold80D
using ..A7_Spectral
using ..CurvatureEnvelope
using ..HolonomyField
using ..TopologyOperator

# ============================================================
#  Rényi Entropy Computation
# ============================================================

"""
    compute_renyi_entropy(p, α)

Computes Rényi entropy:

    H_α(p) = 1 / (1 - α) * log( ∑ pᵢ^α )

Inputs:
- p: probability vector (non-negative, sums to 1)
- α: Rényi order (α > 0, α ≠ 1)

Outputs:
- H_α: scalar entropy
- p_norm: normalized probability vector

Altitude: A4.
"""
function compute_renyi_entropy(p::Vector{Float64}, α::Float64)
    if α <= 0 || α == 1
        error("Rényi entropy requires α > 0 and α ≠ 1.")
    end

    # Normalize p
    total = sum(p)
    if total <= 0
        error("Probability vector must have positive sum.")
    end
    p_norm = p ./ total

    # Compute entropy
    sum_term = sum(p_norm .^ α)
    Hα = (1 / (1 - α)) * log(sum_term)

    return (entropy=Hα, p=p_norm, α=α)
end


# ============================================================
#  Entropy → Manifold Embedding
# ============================================================

"""
    embed_entropy_geometry(entropy_obj, M)

Embeds Rényi entropy geometry into the 80D soft manifold.

Steps:
1. Construct entropy vector e_raw ∈ ℝ⁸⁰
2. Spectral projection
3. Curvature modulation
4. Holonomy transport
5. Topology modulation

Returns:
- embedded vector e ∈ ℝ⁸⁰

Altitude: A5 → A7 → A8.
"""
function embed_entropy_geometry(entropy_obj::NamedTuple,
                                M::Manifold80D.SoftManifold80D)

    p = entropy_obj.p
    Hα = entropy_obj.entropy
    α = entropy_obj.α

    # Step 1: Construct entropy vector
    v = zeros(Float64, M.dim)

    # Encode probability distribution into first coordinates
    for i in 1:min(length(p), M.dim-2)
        v[i] = p[i]
    end

    # Encode entropy and α into slack dimensions
    v[end-1] = Hα / (1 + abs(Hα))
    v[end]   = α / (1 + α)

    # Step 2: Spectral projection
    λ, U = A7_Spectral.spectral_decomposition(M)
    s = U' * v

    # Step 3: Curvature modulation
    κ = CurvatureEnvelope.compute_curvature_envelope(M)
    c = s .* (1 .+ 0.1 .* κ)

    # Step 4: Holonomy transport
    h = HolonomyField.holonomy_transport(c, M)

    # Step 5: Topology modulation
    τ = TopologyOperator.compute_topology_signature(M)
    e = h .* (1 .+ 0.05 .* τ)

    return e
end

end # module
