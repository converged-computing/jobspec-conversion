#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/masato1122/md2tau/examples/1_prepare_lammps/UTIL/mkscripts.sh
