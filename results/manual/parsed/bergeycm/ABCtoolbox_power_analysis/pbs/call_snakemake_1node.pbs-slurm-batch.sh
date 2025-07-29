#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/bergeycm/ABCtoolbox_power_analysis/pbs/call_snakemake_1node.pbs
