#!/bin/bash
#SBATCH --output=lammps_indent.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=4

export PATH='$PATH:$PWD/../../../lammps-mpi-most-23Jun2022/bin'

module load cmake gcc/11.3.0 openmpi/4.1.5 fftw/3.3.10 openblas/0.3.23 eigen/3.4.0 ffmpeg/6.0  voropp/0.4.6 zstd/1.5.5
export PATH=$PATH:$PWD/../../../lammps-mpi-most-23Jun2022/bin
srun lmp < in.indent
