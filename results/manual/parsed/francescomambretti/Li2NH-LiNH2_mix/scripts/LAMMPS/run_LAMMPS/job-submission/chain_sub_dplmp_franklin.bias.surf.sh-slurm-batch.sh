#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/francescomambretti/Li2NH-LiNH2_mix/scripts/LAMMPS/run_LAMMPS/job-submission/chain_sub_dplmp_franklin.bias.surf.sh
