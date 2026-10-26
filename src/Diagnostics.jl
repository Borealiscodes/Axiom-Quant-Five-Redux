module Diagnostics

using ..Runtime
using ..InvariantSuite
using ..Manifold80D

export DiagnosticReport, generate_report

"""
    DiagnosticReport

Represents a human-readable diagnostic summary of the Redux runtime.
Stores:
- manifold summary
- domain summaries
- invariant summaries
- combined score
"""
struct DiagnosticReport
    manifold_summary::String
    domain_summary::String
    invariant_summary::String
    combined_score::Float64
end


"""
    generate_report(runtime)

Produces a structured diagnostic report from a RuntimeState.
Altitude: full span (A3 → A8).
"""
function generate_report(runtime::Runtime.RuntimeState)

    # --- Manifold summary ---
    M = runtime.manifold
    manifold_summary = """
    Soft Manifold Diagnostics:
    - Dimension: $(M.dim)
    - Metric norm: $(norm(M.metric))
    - Curvature envelope norm: $(norm(M.curvature))
    - Holonomy drift norm: $(norm(M.holonomy))
    """

    # --- Domain summary ---
    D = runtime.domains
    domain_summary = """
    Domain Diagnostics:
    - Erdős Graph: n=$(D.G.n), p=$(D.G.p)
    - BitNet Ternary: jumps=$(sum(abs.(diff(D.B.ternary))))
    - Markowitz Frontier: weight variance=$(var(D.MK.weights))
    - Black–Scholes: vol surface mean=$(mean(D.BS.vol_surface))
    - Rényi Dyadic: entropy=$(D.R.entropy)
    """

    # --- Invariant summary ---
    I = runtime.invariants
    invariant_summary = """
    Invariant Diagnostics:
    - Connectivity Invariant: $(I.connectivity.invariant)
    - Quantization Invariant: $(I.quantization.invariant)
    - Convexity Invariant: $(I.convexity.invariant)
    - Canonical Form Invariant: $(I.canonical_form.invariant)
    - Entropy Shift Invariant: $(I.entropy_shift.invariant)
    """

    return DiagnosticReport(
        manifold_summary,
        domain_summary,
        invariant_summary,
        I.combined_score
    )
end

end # module
