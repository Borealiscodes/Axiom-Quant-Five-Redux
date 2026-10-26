using Test
using Redux

@testset "Black-Scholes Volatility Domain" begin
    σ = 0.3
    M = Redux.Manifold80D.SoftManifold80D()

    E = Redux.BlackScholesVol.embed_vol_geometry(σ, M)

    @test length(E) == M.dim
    @test all(isfinite, E)
end
