#!/bin/bash
#FLUX: --job-name=peachy-noodle-6503
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load contrib/dls-spectroscopy/quantum-espresso/6.5-intel-18.0.3
mpirun -np ${SLURM_NTASKS} pw.x -inp iro2.pwi > iro2.pwo
