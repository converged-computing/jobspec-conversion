#!/bin/bash
#SBATCH --job-name=liquid
#SBATCH --output=output.out1
#SBATCH --error=error.err1
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=NVIDIAGeForceRTX4090
#SBATCH --exclude=node29

module load compiler/gcc/7.3.1
module load compiler/intel/2021.3.0
module load mpi/intelmpi/2021.3.0
module swap apps/gromacs/intelmpi/2021.7-4090
module load mathlib/fftw/intelmpi/3.3.9_single
i=395
gmx_mpi mdrun -ntomp 16 -v -pin on -deffnm ./$i/md -gpu_id 0 -pme gpu -nb gpu
