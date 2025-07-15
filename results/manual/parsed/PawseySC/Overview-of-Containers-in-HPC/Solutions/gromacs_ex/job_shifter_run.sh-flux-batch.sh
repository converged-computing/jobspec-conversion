#!/bin/bash
#FLUX: --job-name=Container_Gromacs
#FLUX: --queue=gpuq
#FLUX: -t=3600
#FLUX: --priority=16

module load shifter
srun --export=all shifter run nvcr.io/hpc/gromacs:2018.2 gmx grompp -f pme.mdp
srun --export=all shifter run nvcr.io/hpc/gromacs:2018.2 \
    gmx mdrun -ntmpi 1 -nb gpu -pin on -v -noconfout -nsteps 5000 -s topol.tpr -ntomp 1
