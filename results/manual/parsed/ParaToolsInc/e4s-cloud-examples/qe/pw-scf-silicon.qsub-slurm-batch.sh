#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ParaToolsInc/e4s-cloud-examples/qe/pw-scf-silicon.qsub
