namespace AxiomQuant.Pipeline

open AxiomQuant.Manifold
open AxiomQuant.Operators.Spectral
open AxiomQuant.Operators.Curvature
open AxiomQuant.Operators.Holonomy
open AxiomQuant.Operators.Topology
open AxiomQuant.Operators.Invariant

/-- Full embedding pipeline E -/
def E : Manifold80 → Invariant :=
  fun x => Phi9 (Phi8t (Phi8 (Phi7 (Phi5 x))))

end AxiomQuant.Pipeline
