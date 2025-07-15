#!/bin/bash
#FLUX: --job-name=hairy-plant-0359
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load contrib/dls-spectroscopy/quantum-espresso/7.3.1-GCC-12.2.0
mpirun -np ${SLURM_NTASKS} pw.x -inp c60_scf.pwi > c60_scf.pwo
