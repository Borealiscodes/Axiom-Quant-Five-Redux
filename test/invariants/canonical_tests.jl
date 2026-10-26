using Test
using Redux

@testset "Canonical-Form Invariant" begin
    M = Redux.Manifold80D.SoftManifold80D()
    v = randn(M.dim)

    S = Redux.CanonicalFormInvariant.canonical_score(v, M)
    I = Redux.CanonicalFormInvariant.canonical_invariant(v, M)

    @test S > 0
    @test I > 0
end
