#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/iraikov/neuroh5/jobscripts/bluewaters_mpirun_Full_Scale_Control_512.sh
