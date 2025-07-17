#!/bin/bash
#FLUX: --job-name=test-gpu
#FLUX: --queue=gpu-shared
#FLUX: -t=600
#FLUX: --urgency=16

module load singularity
module unload mvapich2_ib
module load openmpi_ib
rm -f test-results-gpu.out
ibrun -n 1 singularity exec --nv software.simg python3 serial-gpu.py
