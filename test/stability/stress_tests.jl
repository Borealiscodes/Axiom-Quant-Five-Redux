using Test
using Redux

@testset "Stress Tests — High Magnitude Inputs" begin
    M = Redux.Manifold80D.SoftManifold80D()

    # Very large vector
    v = 1e6 .* randn(M.dim)

    F = Redux.Runtime.evaluate_geometry(Redux.Runtime.ReduxRuntime(M), v)

    @test length(F) == M.dim
    @test all(isfinite, F)
end

@testset "Stress Tests — Near-Zero Inputs" begin
    M = Redux.Manifold80D.SoftManifold80D()

    v = 1e-12 .* randn(M.dim)

    F = Redux.Runtime.evaluate_geometry(Redux.Runtime.ReduxRuntime(M), v)

    @test length(F) == M.dim
    @test all(isfinite, F)
end
