[Mesh]
  type = GeneratedMesh
  dim  = 2
  nx   = 100
  ny   = 10
  xmax = 0.304 # length of test chamber
  ymax = 0.0257 # test chamber radius
[]

[Problem]
  type = FEProblem
  coord_type = RZ # axisymmetric RZ
  rz_coord_axis = X # which axix the symmetry is around
[]

[Variables]
  [pressure]
    # adds a linear lagrange variable by default
  []
[]

[Kernels]
  [diffusion]
    type = DarcyPressure # Laplacian operator
    variable = pressure # operate on the "pressure" variable from above
    permeability = 0.8451e-09 #(m^2) assumed permeability of the porous medium
  []
[]

[BCs]
  [inlet]
    type = ADDirichletBC
    variable = pressure
    boundary = left # name of a sideset in the mesh
    value = 4000 # (Pa)
  []
  [outlet]
    type = ADDirichletBC
    variable = pressure
    boundary = right
    value = 0 # (Pa)
  []
[]

[Executioner]
  type = Steady
  solve_type = NEWTON # perform a newton solve
  # Set PETSc parameters to optimize solver efficiency
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value  = ' hypre    boomeramg'
[]

[Outputs]
  exodus = true
[]

