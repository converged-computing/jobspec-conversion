#!/bin/bash
#FLUX: --job-name=gloopy-peanut-1690
#FLUX: --priority=16

eval $(spack load --sh r-rmpi@0.6-9.2 ^r@4.1.3 ^openmpi@4.1.3 schedulers=slurm legacylaunchers=true ^slurm@20-11-9-1)
mpirun -np 1 Rscript r_mpi_example.r
