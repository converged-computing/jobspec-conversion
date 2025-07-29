#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/geodynamics/relax/examples/elmayor/Forward%20modeling/Lower_crust/Lower_crust_Newtonian_rheology_uniform_thickness_12kmthick/Lower_crust_Newtonian_rheology_uniformthickness_12kmthick.sh
