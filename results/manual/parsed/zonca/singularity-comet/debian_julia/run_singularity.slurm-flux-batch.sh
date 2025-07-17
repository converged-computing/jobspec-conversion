#!/bin/bash
#FLUX: --job-name=singularity
#FLUX: -N=2
#FLUX: --queue=compute
#FLUX: -t=300
#FLUX: --urgency=16

module load singularity/2.2 mvapich2_ib/2.1
IMAGE=/oasis/scratch/comet/$USER/temp_project/julia.img
mpirun singularity exec $IMAGE /usr/bin/hellow
mpirun singularity exec $IMAGE /usr/local/julia/bin/julia 01-hello.jl
