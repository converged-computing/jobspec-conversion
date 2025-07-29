#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/cucinotta-group/cp2k-smeagol-examples/examples/au-wire-solvated/calculations/md/equilibration/water-166_aspc_ADDED_MOS-1000/run.slurm
