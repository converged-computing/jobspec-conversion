#!/bin/bash
#FLUX: --job-name="-gpu"
#FLUX: -N=4
#FLUX: -t=86400
#FLUX: --priority=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export NO_STOP_MESSAGE='1'
export CRAY_CUDA_MPS='1 # to '

module load daint-gpu
module load LAMMPS/23Jun2022-CrayGNU-21.09-cuda
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export NO_STOP_MESSAGE=1
export CRAY_CUDA_MPS=1 # to 
ulimit -s unlimited
echo "start MD..."
srun lmp_mpi -sf gpu -in in.lammps
