using Test
using Redux

@testset "Cross-Operator Consistency" begin
    M = Redux.Manifold80D.SoftManifold80D()
    v = randn(M.dim)

    S = Redux.A7_Spectral.spectral_decomposition(M)[1]
    C = Redux.CurvatureEnvelope.curvature_envelope(v, M)
    H = Redux.HolonomyField.holonomy_transport(v, M)
    T = Redux.TopologyOperator.topology_signature(v, M)
    F = Redux.FusionOperator.fuse_geometry(v, M)

    # All operators must preserve dimension
    @test length(C) == M.dim
    @test length(H) == M.dim
    @test length(T) == M.dim
    @test length(F) == M.dim

    # Fusion should not be identical to any single operator
    @test norm(F - C) > 1e-3
    @test norm(F - H) > 1e-3
    @test norm(F - T) > 1e-3
end
