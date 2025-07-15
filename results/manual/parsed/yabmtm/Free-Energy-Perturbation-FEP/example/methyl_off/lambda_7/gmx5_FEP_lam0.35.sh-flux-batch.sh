#!/bin/bash
#FLUX: --job-name=bumfuzzled-kitty-8202
#FLUX: --urgency=16

export OMP_NUM_THREADS='16'

module load boost
module load gromacs/5.0.4
module load cuda/6.0
export OMP_NUM_THREADS=16
mdrun_gpu -s topol.tpr -maxh 23.5
