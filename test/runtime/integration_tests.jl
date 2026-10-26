using Test
using Redux

@testset "Full Runtime Integration" begin
    M = Redux.Manifold80D.SoftManifold80D()
    rt = Redux.Runtime.ReduxRuntime(M)

    # Domain inputs
    graph_vec = randn(M.dim)
    ternary_vec = [-1.0, 0.2, 0.7, -0.3]
    markowitz_vec = rand(10)
    sigma = 0.25
    beta = 0.7

    # Embeddings
    E_graph = Redux.ErdosGraph.embed_graph_geometry(graph_vec, M)
    E_ternary = Redux.BitNetTernary.embed_ternary_geometry(ternary_vec, M)
    E_frontier = Redux.MarkowitzFrontier.embed_frontier_geometry(markowitz_vec, M)
    E_vol = Redux.BlackScholesVol.embed_vol_geometry(sigma, M)
    E_entropy = Redux.RenyiEntropy.embed_entropy_geometry(beta, M)

    # Runtime outputs
    F_graph = Redux.Runtime.evaluate_geometry(rt, E_graph)
    F_ternary = Redux.Runtime.evaluate_geometry(rt, E_ternary)
    F_frontier = Redux.Runtime.evaluate_geometry(rt, E_frontier)
    F_vol = Redux.Runtime.evaluate_geometry(rt, E_vol)
    F_entropy = Redux.Runtime.evaluate_geometry(rt, E_entropy)

    # Invariants must be finite and positive
    for F in (F_graph, F_ternary, F_frontier, F_vol, F_entropy)
        inv = Redux.Runtime.evaluate_all_invariants(rt, F)
        @test inv.connectivity > 0
        @test inv.quantization > 0
        @test inv.convexity > 0
        @test inv.canonical_form > 0
        @test inv.entropy_shift > 0
    end
end
