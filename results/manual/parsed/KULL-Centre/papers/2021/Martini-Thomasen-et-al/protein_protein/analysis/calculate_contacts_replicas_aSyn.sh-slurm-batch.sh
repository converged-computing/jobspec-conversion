#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/KULL-Centre/papers/2021/Martini-Thomasen-et-al/protein_protein/analysis/calculate_contacts_replicas_aSyn.sh
