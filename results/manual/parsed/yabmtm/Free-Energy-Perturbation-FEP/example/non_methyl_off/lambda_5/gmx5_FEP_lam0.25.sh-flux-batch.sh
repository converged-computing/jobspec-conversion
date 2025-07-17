#!/bin/bash
#FLUX: --job-name=g_methyl_lam0.25.pf
#FLUX: -n=16
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='16'

module load boost
module load gromacs/5.0.4
module load cuda/6.0
export OMP_NUM_THREADS=16
mdrun_gpu -s topol.tpr -maxh 23.5
