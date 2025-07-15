#!/bin/bash
#FLUX: --job-name=swampy-kitty-7895
#FLUX: --queue=parallel
#FLUX: --priority=16

export SLURM_MPI_TYPE='pmi2'
export OMP_NUM_THREADS='28'
export MKL_NUM_THREADS='28'

export SLURM_MPI_TYPE=pmi2
export OMP_NUM_THREADS=28
export MKL_NUM_THREADS=28
module load gcc-5.4.0/boost-1.55.0-openmpi-1.10.3 
source /home/zhcui/.bashrc
srun hostname
ulimit -l unlimited
python ./hub2d.ti.py 4.0 . 0.9
