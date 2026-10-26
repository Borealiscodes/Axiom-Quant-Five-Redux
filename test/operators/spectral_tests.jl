using Test
using Redux

@testset "Spectral Operator" begin
    M = Redux.Manifold80D.SoftManifold80D()
    λ, U = Redux.A7_Spectral.spectral_decomposition(M)

    @test length(λ) == M.dim
    @test size(U) == (M.dim, M.dim)
    @test isapprox(U * U', I, atol=1e-6)
end
