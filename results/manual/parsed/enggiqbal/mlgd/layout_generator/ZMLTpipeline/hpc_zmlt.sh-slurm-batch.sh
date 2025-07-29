#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/enggiqbal/mlgd/layout_generator/ZMLTpipeline/hpc_zmlt.sh
