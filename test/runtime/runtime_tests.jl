using Test
using Redux

@testset "Redux Runtime" begin
    rt = Redux.Runtime.ReduxRuntime(Redux.Manifold80D.SoftManifold80D())

    v = randn(rt.manifold.dim)
    F = Redux.Runtime.evaluate_geometry(rt, v)

    @test length(F) == rt.manifold.dim

    inv = Redux.Runtime.evaluate_all_invariants(rt, F)

    @test inv.connectivity > 0
    @test inv.quantization > 0
    @test inv.convexity > 0
    @test inv.canonical_form > 0
    @test inv.entropy_shift > 0
end
