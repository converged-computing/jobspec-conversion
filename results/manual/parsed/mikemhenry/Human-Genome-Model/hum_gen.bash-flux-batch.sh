#!/bin/bash
#FLUX: --job-name=placid-chip-5350
#FLUX: --queue=gpuq
#FLUX: -t=86400
#FLUX: --urgency=16

ulimit -u 9999
ulimit -s unlimited
ulimit -v unlimited
module load hoomd-blue/gcc/mvapich2/2.1.5
mpirun python hum_gen.py
