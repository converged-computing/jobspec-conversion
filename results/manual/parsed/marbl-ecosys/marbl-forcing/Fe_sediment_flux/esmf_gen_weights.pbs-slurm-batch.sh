#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/marbl-ecosys/marbl-forcing/Fe_sediment_flux/esmf_gen_weights.pbs
