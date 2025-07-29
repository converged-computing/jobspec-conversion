#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/marbl-ecosys/forcing-Fe-sedflux/notebooks/esmf_gen_weights_etopo1_to_POP.pbs
