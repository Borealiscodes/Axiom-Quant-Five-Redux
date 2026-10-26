using Test
using Redux

@testset "Curvature Envelope Operator" begin
    M = Redux.Manifold80D.SoftManifold80D()
    v = randn(M.dim)

    C = Redux.CurvatureEnvelope.curvature_envelope(v, M)

    @test length(C) == M.dim
    @test all(isfinite, C)

    # Perturbation stability
    v2 = v .+ 1e-6 .* randn(M.dim)
    C2 = Redux.CurvatureEnvelope.curvature_envelope(v2, M)

    @test norm(C - C2) < 1e-3
end
