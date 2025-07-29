#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/UnDiFi/UnDiFi-2D/EulFS.3.14/src/mpi/buildscript/make_on_matrix_linux_intel-11.1.064-opt
