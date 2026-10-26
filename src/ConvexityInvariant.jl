module ConvexityInvariant

using ..MarkowitzFrontier
using ..Manifold80D
using ..A5_LatentSemantics
using ..A7_Spectral
export ConvexityInvariantState, compute_convexity_invariant

"""
    ConvexityInvariantState

Represents the convexity curvature invariant for an embedded Markowitz frontier.
Stores:
- raw convexity score
- manifold projection
- invariant value
"""
struct ConvexityInvariantState
    convexity_score::Float64
    projection::Vector{Float64}
    invariant::Float64
    altitude::Int
end


"""
    compute_convexity_invariant(MK, M)

Computes a placeholder convexity invariant:
- convexity_score = variance of frontier weights
- projection = manifold embedding of frontier
- invariant = convexity_score * norm(projection)

Altitude: A5 → A7 invariant extraction.
"""
function compute_convexity_invariant(MK::MarkowitzFrontier.MarkowitzState,
                                     M::Manifold80D.SoftManifold80D)

    # A5 latent-semantic validation
    A5_LatentSemantics.route_to_A5(MK.weights)

    # Raw convexity: variance of weights
    convexity_score = var(MK.weights)

    # Manifold projection
    projection = MarkowitzFrontier.embed_markowitz_in_manifold(MK, M)

    # A7 spectral routing (convexity interacts with curvature envelope)
    A7_Spectral.route_to_A7(projection, M)

    # Invariant: placeholder norm-based curvature proxy
    invariant_value = convexity_score * norm(projection)

    return ConvexityInvariantState(convexity_score, projection, invariant_value, 7)
end

end # module
