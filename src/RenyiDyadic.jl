module RenyiDyadic

using ..Manifold80D
using ..CurvatureEnvelope
using ..HolonomyField
using ..A8_SoftManifold
export RenyiState, compute_renyi_entropy, embed_renyi_in_manifold

"""
    RenyiState

Represents a Rényi entropy profile at altitude A8.
Stores the probability vector, α parameter, and entropy value.
"""
struct RenyiState
    probs::Vector{Float64}
    alpha::Float64
    entropy::Float64
    altitude::Int
end


"""
    compute_renyi_entropy(p, α)

Computes the Rényi entropy:
    H_α(p) = (1 / (1 - α)) * log(sum(p_i^α))
Altitude: A8 (soft manifold geometry).
"""
function compute_renyi_entropy(p::Vector{Float64}, α::Float64)
    # Normalize probabilities
    Z = sum(p)
    q = p ./ Z

    # Compute entropy
    S = (1 / (1 - α)) * log(sum(q .^ α))

    # Route through A8 altitude
    A8_SoftManifold.route_to_A8(q, Manifold80D.initialize_manifold())

    return RenyiState(q, α, S, 8)
end


"""
    embed_renyi_in_manifold(R, M)

Embeds the Rényi entropy profile into the 80D soft manifold.
Altitude: A8 → manifold projection.
Uses:
- curvature envelope
- holonomy drift
- slack dimensions
"""
function embed_renyi_in_manifold(R::RenyiState, M::Manifold80D.SoftManifold80D)
    CE = CurvatureEnvelope.compute_curvature_envelope(M)
    H  = HolonomyField.compute_connection_form(M)

    projection = zeros(Float64, M.dim)

    # Placeholder: entropy modulated by curvature + holonomy drift
    for i in 1:M.dim
        projection[i] = R.entropy * (1.0 + 0.001 * CE.envelope[i]) + 0.0005 * H.drift_field[i]
    end

    return projection
end

end # module
