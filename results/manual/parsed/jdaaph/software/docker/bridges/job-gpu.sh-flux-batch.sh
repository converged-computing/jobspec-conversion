#!/bin/bash
#FLUX: --job-name=test-gpu
#FLUX: --queue=GPU-small
#FLUX: -t=600
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load singularity/2.6.0
module unload intel
module load mpi/gcc_openmpi
rm -f test-results-gpu.out
mpirun -n 1 singularity exec --nv software.simg python3 serial-gpu.py
