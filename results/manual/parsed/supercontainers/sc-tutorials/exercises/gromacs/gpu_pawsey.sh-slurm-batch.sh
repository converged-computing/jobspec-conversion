#!/bin/bash
#SBATCH --job-name=gpu
#SBATCH --output=gpu_pawsey.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH --partition=gpuq

image="docker://nvcr.io/hpc/gromacs:2018.2"
module load singularity
if [ -e conf.gro.gz ] ; then
 gunzip conf.gro.gz
fi
srun singularity exec --nv $image \
    gmx grompp -f pme.mdp
srun singularity exec --nv $image \
    gmx mdrun -ntmpi 1 -nb gpu -pin on -v -noconfout -nsteps 5000 -s topol.tpr -ntomp 1
