#!/bin/bash
#FLUX: --job-name=run_lammps
#FLUX: -N=2
#FLUX: --queue=cpu
#FLUX: --urgency=16

module load oneapi/2021
KMP_BLOCKTIME=0 mpirun -n 80 singularity run $YOUR_IMAGE_PATH  lmp -i in.eam
