using Test
using Redux

@testset "Convexity Invariant" begin
    M = Redux.Manifold80D.SoftManifold80D()
    v = randn(M.dim)

    C = Redux.ConvexityInvariant.convexity_invariant(v, M)

    @test isfinite(C)
    @test C > 0
end
