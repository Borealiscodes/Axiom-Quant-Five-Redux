using Test
using Redux

@testset "Quantization Invariant" begin
    M = Redux.Manifold80D.SoftManifold80D()
    v = randn(M.dim)

    Q = Redux.QuantizationInvariant.quantization_invariant(v, M)

    @test isfinite(Q)
    @test Q > 0
end
