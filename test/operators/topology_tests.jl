using Test
using Redux

@testset "Topology Signature Operator" begin
    M = Redux.Manifold80D.SoftManifold80D()
    v = randn(M.dim)

    T = Redux.TopologyOperator.topology_signature(v, M)

    @test length(T) == M.dim
    @test all(isfinite, T)

    # Topology signature should be stable under tiny perturbations
    v2 = v .+ 1e-6 .* randn(M.dim)
    T2 = Redux.TopologyOperator.topology_signature(v2, M)

    @test norm(T - T2) < 1e-3
end
