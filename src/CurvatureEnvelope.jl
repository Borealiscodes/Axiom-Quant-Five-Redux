module CurvatureEnvelope

export compute_curvature_envelope, sectional_curvature, curvature_energy

using LinearAlgebra
using ..Manifold80D

# ============================================================
#  Sectional Curvature Proxy
# ============================================================

"""
    sectional_curvature(M, i, j)

Computes a sectional curvature proxy K(eᵢ, eⱼ) using the metric
diagonal and finite-difference approximations.

Altitude: A8.
"""
function sectional_curvature(M::Manifold80D.SoftManifold80D, i::Int, j::Int)
    dim = M.dim
    if i < 1 || j < 1 || i > dim || j > dim
        error("Sectional curvature index out of bounds.")
    end

    diag_metric = diag(M.metric)

    # Finite-difference curvature proxy
    Ki = (i > 1 && i < dim) ? diag_metric[i+1] - 2*diag_metric[i] + diag_metric[i-1] : 0.0
    Kj = (j > 1 && j < dim) ? diag_metric[j+1] - 2*diag_metric[j] + diag_metric[j-1] : 0.0

    # Combine into a symmetric curvature proxy
    return 0.5 * (Ki + Kj)
end


# ============================================================
#  Curvature Envelope
# ============================================================

"""
    compute_curvature_envelope(M)

Computes the curvature envelope κ ∈ ℝ⁸⁰ by aggregating sectional
curvature proxies across adjacent coordinate planes.

Altitude: A8.
"""
function compute_curvature_envelope(M::Manifold80D.SoftManifold80D)
    dim = M.dim
    κ = zeros(Float64, dim)

    for i in 1:(dim-1)
        κ[i] = sectional_curvature(M, i, i+1)
    end

    # Normalize curvature envelope
    κ .= κ ./ (1 .+ abs.(κ))

    return κ
end


# ============================================================
#  Curvature Energy
# ============================================================

"""
    curvature_energy(v, M)

Computes curvature energy:

    C(v) = ∑ κᵢ vᵢ²

where κ is the curvature envelope.

Altitude: A7/A8.
"""
function curvature_energy(v::Vector{Float64}, M::Manifold80D.SoftManifold80D)
    if length(v) != M.dim
        error("Curvature energy error: vector dimension mismatch.")
    end

    κ = compute_curvature_envelope(M)
    return sum(κ .* (v .^ 2))
end

end # module
