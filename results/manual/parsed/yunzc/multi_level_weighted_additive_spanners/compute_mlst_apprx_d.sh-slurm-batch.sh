#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/yunzc/multi_level_weighted_additive_spanners/compute_mlst_apprx_d.sh
