namespace AxiomQuant.Domain

open AxiomQuant.Manifold
open AxiomQuant.Operators.Spectral
open AxiomQuant.Operators.Curvature
open AxiomQuant.Operators.Holonomy
open AxiomQuant.Operators.Topology

def DomainD1 : Manifold80 → Prop := fun _ => True
def DomainD2 : Spectral → Prop := fun _ => True
def DomainD3 : Curvature → Prop := fun _ => True
def DomainD4 : Holonomy → Prop := fun _ => True
def DomainD5 : Topology → Prop := fun _ => True

end AxiomQuant.Domain
