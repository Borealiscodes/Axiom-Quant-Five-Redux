using Test
using Redux

# Operators
include("operators/spectral_tests.jl")
include("operators/curvature_tests.jl")
include("operators/holonomy_tests.jl")
include("operators/topology_tests.jl")
include("operators/fusion_tests.jl")

# Domains
include("domains/erdos_tests.jl")
include("domains/ternary_tests.jl")
include("domains/frontier_tests.jl")
include("domains/vol_tests.jl")
include("domains/entropy_tests.jl")

# Invariants
include("invariants/connectivity_tests.jl")
include("invariants/quantization_tests.jl")
include("invariants/convexity_tests.jl")
include("invariants/canonical_tests.jl")
include("invariants/entropy_shift_tests.jl")

# Runtime
include("runtime/runtime_tests.jl")

# Stability
include("stability/perturbation_tests.jl")
include("stability/altitude_tests.jl")
