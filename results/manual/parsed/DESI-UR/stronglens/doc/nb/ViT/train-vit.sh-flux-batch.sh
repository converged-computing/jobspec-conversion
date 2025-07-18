#!/bin/bash
#FLUX: --job-name=stronglens-vit-training
#FLUX: --queue=regular
#FLUX: -t=32400
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
module load pytorch/1.13.1
srun -n 1 -c 128 --cpu_bind=cores -G 1 --gpu-bind=single:1 python /pscratch/sd/d/dcummins/vit/Training.py
