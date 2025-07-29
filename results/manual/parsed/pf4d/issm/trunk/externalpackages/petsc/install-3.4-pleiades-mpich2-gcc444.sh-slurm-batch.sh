#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/pf4d/issm/trunk/externalpackages/petsc/install-3.4-pleiades-mpich2-gcc444.sh
