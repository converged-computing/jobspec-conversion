#!/bin/bash
#SBATCH --job-name=Container_Gromacs
#SBATCH --account=onlinecourse
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00

module load shifter
srun --export=all shifter run nvcr.io/hpc/gromacs:2018.2 gmx grompp -f pme.mdp
srun --export=all shifter run nvcr.io/hpc/gromacs:2018.2 \
    gmx mdrun -ntmpi 1 -nb gpu -pin on -v -noconfout -nsteps 5000 -s topol.tpr -ntomp 1
