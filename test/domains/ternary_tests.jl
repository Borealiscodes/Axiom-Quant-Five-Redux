using Test
using Redux

@testset "BitNet Ternary Domain" begin
    x = [-1.0, -0.2, 0.3, 0.7]
    Q = Redux.BitNetTernary.quantize_ternary(x)

    @test Q.q == [-1, 0, 0, 1]
    @test Q.jumps > 0

    M = Redux.Manifold80D.SoftManifold80D()
    e = Redux.BitNetTernary.embed_ternary_geometry(x, M)

    @test length(e) == M.dim
end
