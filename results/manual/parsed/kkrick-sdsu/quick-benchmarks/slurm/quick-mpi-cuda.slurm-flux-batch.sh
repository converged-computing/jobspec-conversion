#!/bin/bash
#FLUX: --job-name=quick-mpi-cuda
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module reset
module load singularitypro
singularity exec --nv --bind /expanse,/scratch \
    containers/quick_mpi-cuda-12.0.1.sif \
    ./bench.sh \
    -i ./input \
    -o ./output \
    -f psb5,morphine,taxol,valinomycin \
    -c quick.cuda.MPI
