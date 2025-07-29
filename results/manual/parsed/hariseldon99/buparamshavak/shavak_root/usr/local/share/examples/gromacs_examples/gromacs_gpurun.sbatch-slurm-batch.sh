#!/bin/bash
#SBATCH --job-name=gromacstest
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00

export GMX_IMGDIR='${SIFDIR}/gromacs/'
export GMX_IMG='gromacs-2022.3_20230206.sif'
export TOPOL_FILE='topol.tpr'

export GMX_IMGDIR=${SIFDIR}/gromacs/
export GMX_IMG=gromacs-2022.3_20230206.sif
export TOPOL_FILE=topol.tpr
singularity run --nv -B ${PWD}:/host_pwd --pwd /host_pwd  $GMX_IMGDIR/$GMX_IMG gmx mdrun -ntmpi 1 -nb gpu -pin on -v -noconfout -nsteps 5000 -ntomp ${SLURM_NTASKS} -s $TOPOL_FILE
