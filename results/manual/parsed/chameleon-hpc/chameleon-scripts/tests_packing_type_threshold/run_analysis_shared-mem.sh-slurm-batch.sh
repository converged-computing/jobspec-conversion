#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/chameleon-hpc/chameleon-scripts/tests_packing_type_threshold/run_analysis_shared-mem.sh
