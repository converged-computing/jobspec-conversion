#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/KULL-Centre/papers/2021/Martini-Thomasen-et-al/protein_protein/run_simulations/FUS/prodrun_grompp.sh
