#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/geodynamics/relax/examples/elmayor/Forward%20modeling/Coupled_models/Coupled_model2/Coupled_model2.sh
