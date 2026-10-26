module Redux

# --- Core system imports ---
using ..Runtime
using ..Diagnostics
using ..InvariantSuite

# --- Domain imports ---
using ..ErdosGraph
using ..BitNetTernary
using ..MarkowitzFrontier
using ..BlackScholesVol
using ..RenyiDyadic

# --- Invariant imports ---
using ..ConnectivityInvariant
using ..QuantizationInvariant
using ..ConvexityInvariant
using ..CanonicalFormInvariant
using ..EntropyShiftInvariant

# --- Manifold ---
using ..Manifold80D

export redux, ReduxResult

"""
    ReduxResult

Unified output of the top-level Redux orchestrator.
Stores:
- runtime state
- diagnostic report
"""
struct ReduxResult
    runtime::Runtime.RuntimeState
    diagnostics::Diagnostics.DiagnosticReport
end


"""
    redux(config)

Top-level entry point for Axiom-Quant-Five-Redux.

Runs:
1. Full runtime pipeline
2. Full diagnostic pipeline

Returns a `ReduxResult` containing:
- manifold
- domain states
- invariant suite
- diagnostic summaries

`config` is a NamedTuple containing:
- n, p           (Erdos)
- x              (BitNet)
- returns, cov   (Markowitz)
- strikes, mats  (Black-Scholes)
- probs, alpha   (Renyi)
"""
function redux(config::NamedTuple)

    # Run full pipeline
    runtime_state = Runtime.run_redux(config)

    # Generate diagnostics
    diagnostics = Diagnostics.generate_report(runtime_state)

    return ReduxResult(runtime_state, diagnostics)
end

end # module
