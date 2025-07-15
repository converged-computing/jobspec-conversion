#!/bin/bash
#FLUX: --job-name=fat-lizard-4493
#FLUX: --priority=16

module load singularity
srun --mpi=pmi2 singularity run --nv --bind .:/my-dat-files hpc-benchmarks:24.03.sif ./hpcg.sh --dat /my-dat-files/HPCG.dat
