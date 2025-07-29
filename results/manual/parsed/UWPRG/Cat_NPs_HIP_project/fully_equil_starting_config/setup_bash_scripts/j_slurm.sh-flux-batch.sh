#!/bin/bash
#FLUX: --job-name=XXX
#FLUX: --queue=ckpt
#FLUX: --urgency=16

module load cuda/11.1.1-1
module load gcc/10.1.0
module load cmake/3.11.2
source /gscratch/pfaendtner/jpfaendt/codes/gmx2020.5/bin/GMXRC
gmx mdrun -nt XX -gpu_id X -nb gpu -pme cpu -cpi restart -cpo restart -cpt 1.0 &> log.txt
