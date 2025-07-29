#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/YosefLab/theoretical_lineage_tracing_reproducibility/run_sim_validate_k.sh
