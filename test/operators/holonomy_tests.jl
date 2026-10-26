using Test
using Redux

@testset "Holonomy Transport Operator" begin
    M = Redux.Manifold80D.SoftManifold80D()
    v = randn(M.dim)

    H = Redux.HolonomyField.holonomy_transport(v, M)

    @test length(H) == M.dim
    @test all(isfinite, H)

    # Holonomy drift must remain bounded
    @test norm(H - v) < 5.0
end
