module Redux

# Core manifold
include("Manifold80D.jl")

# Operators
include("A7_Spectral.jl")
include("CurvatureEnvelope.jl")
include("HolonomyField.jl")
include("TopologyOperator.jl")
include("FusionOperator.jl")

# Domains
include("ErdosGraph.jl")
include("BitNetTernary.jl")
include("MarkowitzFrontier.jl")
include("BlackScholesVol.jl")
include("RenyiEntropy.jl")

# Invariants
include("ConnectivityInvariant.jl")
include("QuantizationInvariant.jl")
include("ConvexityInvariant.jl")
include("CanonicalFormInvariant.jl")
include("EntropyShiftInvariant.jl")

# Runtime
include("Runtime.jl")

# Export the runtime constructor
export ReduxRuntime, evaluate_geometry, evaluate_all_invariants

end # module
