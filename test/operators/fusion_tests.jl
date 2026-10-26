using Test
using Redux

@testset "Fusion Operator" begin
    M = Redux.Manifold80D.SoftManifold80D()
    v = randn(M.dim)

    F = Redux.FusionOperator.fuse_geometry(v, M)

    @test length(F) == M.dim
    @test all(isfinite, F)

    # Fusion energy must be positive
    @test sum(abs.(F)) > 0
end
