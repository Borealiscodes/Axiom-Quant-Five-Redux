module Runtime

using ..Manifold80D
using ..ErdosGraph
using ..BitNetTernary
using ..MarkowitzFrontier
using ..BlackScholesVol
using ..RenyiDyadic
using ..InvariantSuite

export RuntimeState, run_redux

"""
    RuntimeState

Represents the full runtime output of Axiom-Quant-Five-Redux.
Stores:
- manifold
- domain states
- invariant suite
"""
struct RuntimeState
    manifold::Manifold80D.SoftManifold80D
    domains::NamedTuple
    invariants::InvariantSuite.InvariantSuiteState
end


"""
    run_redux(config)

Runs the full Redux pipeline:
1. Initialize manifold
2. Compute all domain states
3. Compute invariant suite
4. Return unified runtime state

`config` is a NamedTuple containing domain parameters:
- n, p           (Erdos)
- x              (BitNet)
- returns, cov   (Markowitz)
- strikes, mats  (Black-Scholes)
- probs, alpha   (Renyi)
"""
function run_redux(config::NamedTuple)

    # 1. Initialize manifold
    M = Manifold80D.initialize_manifold()

    # 2. Compute domain states
    domains = (
        G  = ErdosGraph.generate_graph(config.n, config.p),
        B  = BitNetTernary.ternary_quantize(config.x),
        MK = MarkowitzFrontier.compute_frontier(config.returns, config.cov),
        BS = BlackScholesVol.compute_vol_surface(config.strikes, config.mats),
        R  = RenyiDyadic.compute_renyi_entropy(config.probs, config.alpha)
    )

    # 3. Compute invariant suite
    invariants = InvariantSuite.compute_invariant_suite(domains, M)

    # 4. Return unified runtime state
    return RuntimeState(M, domains, invariants)
end

end # module
