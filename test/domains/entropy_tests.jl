using Test
using Redux

@testset "Rényi Entropy Domain" begin
    β = 0.7
    M = Redux.Manifold80D.SoftManifold80D()

    E = Redux.RenyiEntropy.embed_entropy_geometry(β, M)

    @test length(E) == M.dim
    @test all(isfinite, E)
end
