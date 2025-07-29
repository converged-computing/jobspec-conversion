#!/bin/bash
#FLUX: --job-name=feots_integrate
#FLUX: --urgency=16

export OMP_NUM_THREADS='8'

module purge
module load gcc openmpi
export OMP_NUM_THREADS=8
cd /home/${USER}/FEOTS/examples/gulfstream_dye/
date
mpirun -np 3 -x OMP_NUM_THREADS ./FEOTSDriver
date
