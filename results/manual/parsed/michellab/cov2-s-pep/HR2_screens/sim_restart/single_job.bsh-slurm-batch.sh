#!/bin/bash
#SBATCH --job-name=SingleMD
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:1
#SBATCH --partition=True
#SBATCH --constraint=ntasks-per-node=1

module load fftw2/intel/float/2.1.5  #Not sure about that one  
module load cuda/10.2                   
module load gromacs/2019/gmx  
gmx  mdrun  -s md.tpr -nice 0 -c md.gro  -nt 3  -ntmpi 1  -append -cpi state.cpt;
