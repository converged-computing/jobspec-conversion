#!/bin/bash
#FLUX: --job-name=gpu
#FLUX: --queue=gpuq
#FLUX: -t=3600
#FLUX: --priority=16

image="docker://nvcr.io/hpc/gromacs:2018.2"
module load singularity
if [ -e conf.gro.gz ] ; then
 gunzip conf.gro.gz
fi
srun singularity exec --nv $image \
    gmx grompp -f pme.mdp
srun singularity exec --nv $image \
    gmx mdrun -ntmpi 1 -nb gpu -pin on -v -noconfout -nsteps 5000 -s topol.tpr -ntomp 1
