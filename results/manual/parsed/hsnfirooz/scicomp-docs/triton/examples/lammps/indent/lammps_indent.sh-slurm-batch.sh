#!/bin/bash
#SBATCH --output=lammps_indent.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=4

export PATH='$PATH:$PWD/../../../lammps-mpi-most-23Jun2022/bin'

module load cmake gcc/8.4.0 openmpi/4.0.5 fftw/3.3.10-openmpi-openmp openblas/0.3.17-openmp eigen/3.4.0 ffmpeg/4.3.2  voropp/0.4.6 zstd/1.5.0
export PATH=$PATH:$PWD/../../../lammps-mpi-most-23Jun2022/bin
srun lmp < in.indent
