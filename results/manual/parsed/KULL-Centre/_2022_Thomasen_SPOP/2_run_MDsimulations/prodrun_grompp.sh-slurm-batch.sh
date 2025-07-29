#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/KULL-Centre/_2022_Thomasen_SPOP/2_run_MDsimulations/prodrun_grompp.sh
