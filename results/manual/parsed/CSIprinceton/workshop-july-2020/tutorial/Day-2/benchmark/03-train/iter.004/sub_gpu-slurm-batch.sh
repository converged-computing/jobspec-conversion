#!/bin/bash
#SBATCH --job-name=Plumed
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=6

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/home/mandrade/lammps/lib/plumed/plumed2/lib'
export OMP_NUM_THREADS='4'

module load cudatoolkit/10.0 cudnn/cuda-10.0/7.6.1
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/mandrade/lammps/lib/plumed/plumed2/lib
code=/home/mandrade/lammps/src/lmp_serial
export OMP_NUM_THREADS=4
$code < lammps.in > out.lammps 
