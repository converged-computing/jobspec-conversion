#!/bin/bash
#FLUX: --job-name=butterscotch-despacito-5095
#FLUX: -n=8
#FLUX: -c=4
#FLUX: --queue=hpg-ai
#FLUX: -t=259200
#FLUX: --priority=16

ml load singularity/3.7.4 cuda/11.4.3
CONTAINER=/apps/nvidia/containers/modulus/modulus_v22.03.sif
srun --unbuffered --mpi=none -n8 --ntasks-per-node 8 singularity exec --nv --bind .:/mnt $CONTAINER python /mnt/fpga_flow.py
