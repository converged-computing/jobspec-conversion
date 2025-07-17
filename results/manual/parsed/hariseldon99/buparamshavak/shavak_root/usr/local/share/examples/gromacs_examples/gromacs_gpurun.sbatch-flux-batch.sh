#!/bin/bash
#FLUX: --job-name=gromacstest
#FLUX: -n=10
#FLUX: --queue=GPU
#FLUX: -t=3600
#FLUX: --urgency=16

export GMX_IMGDIR='${SIFDIR}/gromacs/'
export GMX_IMG='gromacs-2022.3_20230206.sif'
export TOPOL_FILE='topol.tpr'

export GMX_IMGDIR=${SIFDIR}/gromacs/
export GMX_IMG=gromacs-2022.3_20230206.sif
export TOPOL_FILE=topol.tpr
singularity run --nv -B ${PWD}:/host_pwd --pwd /host_pwd  $GMX_IMGDIR/$GMX_IMG gmx mdrun -ntmpi 1 -nb gpu -pin on -v -noconfout -nsteps 5000 -ntomp ${SLURM_NTASKS} -s $TOPOL_FILE
