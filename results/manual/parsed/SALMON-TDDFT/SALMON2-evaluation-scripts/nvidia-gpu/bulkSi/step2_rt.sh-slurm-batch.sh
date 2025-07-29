#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SALMON-TDDFT/SALMON2-evaluation-scripts/nvidia-gpu/bulkSi/step2_rt.sh
