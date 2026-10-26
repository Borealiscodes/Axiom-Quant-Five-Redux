using Test
using Redux

@testset "Perturbation Stability" begin
    M = Redux.Manifold80D.SoftManifold80D()
    rt = Redux.Runtime.ReduxRuntime(M)

    v = randn(M.dim)
    F1 = Redux.Runtime.evaluate_geometry(rt, v)

    v2 = v .+ 1e-6 .* randn(M.dim)
    F2 = Redux.Runtime.evaluate_geometry(rt, v2)

    @test norm(F1 - F2) < 1e-3
end
