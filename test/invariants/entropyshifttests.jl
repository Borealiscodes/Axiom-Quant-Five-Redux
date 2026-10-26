using Test
using Redux

@testset "Entropy-Shift Invariant" begin
    M = Redux.Manifold80D.SoftManifold80D()
    v = randn(M.dim)

    S = Redux.EntropyShiftInvariant.entropy_shift_invariant(v, M)

    @test isfinite(S)
    @test S > 0
end
