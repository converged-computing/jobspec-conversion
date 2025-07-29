#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/geodynamics/relax/examples/elmayor/Forward%20modeling/Lower_crust/Lower_crust_Newtonian_rheology_3D_ST_geometry_topdepth10km/Lower_crust_Newtonian_rheology_3D_ST_geometry_topdepth10km.sh
