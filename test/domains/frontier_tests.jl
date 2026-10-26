using Test
using Redux

@testset "Markowitz Frontier Domain" begin
    w = rand(10)
    M = Redux.Manifold80D.SoftManifold80D()

    E = Redux.MarkowitzFrontier.embed_frontier_geometry(w, M)

    @test length(E) == M.dim
    @test all(isfinite, E)
end
