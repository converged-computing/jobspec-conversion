#!/bin/bash
#FLUX: --job-name=scruptious-noodle-0221
#FLUX: -t=3600
#FLUX: --urgency=16

export PATH='$PATH:$PWD/../../../lammps-mpi-most-23Jun2022/bin'

module load cmake gcc/8.4.0 openmpi/4.0.5 fftw/3.3.10-openmpi-openmp openblas/0.3.17-openmp eigen/3.4.0 ffmpeg/4.3.2  voropp/0.4.6 zstd/1.5.0
export PATH=$PATH:$PWD/../../../lammps-mpi-most-23Jun2022/bin
srun lmp < in.indent
