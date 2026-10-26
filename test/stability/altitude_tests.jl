using Test
using Redux

@testset "Altitude Cleanliness" begin
    M = Redux.Manifold80D.SoftManifold80D()
    v = randn(M.dim)

    # A8 → A3 invariants must be positive and finite
    Iq = Redux.QuantizationInvariant.quantization_invariant(v, M)
    Ic = Redux.ConvexityInvariant.convexity_invariant(v, M)

    @test isfinite(Iq)
    @test isfinite(Ic)
    @test Iq > 0
    @test Ic > 0
end
