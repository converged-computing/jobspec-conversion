#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/choderalab/asapdiscovery-sars-retrospective/science/20230601_hybrid_docking/cluster_scripts/run_fragalysis_retrospective_array.sh
