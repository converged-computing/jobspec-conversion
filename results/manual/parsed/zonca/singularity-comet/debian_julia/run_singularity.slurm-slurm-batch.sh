#!/bin/bash
#SBATCH --job-name=singularity
#SBATCH --account=sds166
#SBATCH --output=singularity.%j.%N.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=compute
#SBATCH --constraint=ntasks-per-node=24

module load singularity/2.2 mvapich2_ib/2.1
IMAGE=/oasis/scratch/comet/$USER/temp_project/julia.img
mpirun singularity exec $IMAGE /usr/bin/hellow
mpirun singularity exec $IMAGE /usr/local/julia/bin/julia 01-hello.jl
