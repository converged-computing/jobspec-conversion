#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ParaFEM/ParaFEM/parafem/src/programs/dev/xx14/job.cray.pbs
