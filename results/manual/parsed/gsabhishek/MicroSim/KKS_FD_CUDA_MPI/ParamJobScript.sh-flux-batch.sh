#!/bin/bash
#FLUX: --job-name=dirty-nalgas-3942
#FLUX: -N=4
#FLUX: -n=8
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load gcc/10.2.0 cuda spack gnu8 gsl
. /home/apps/spack/share/spack/setup-env.sh
spack load nvhpc
mpirun -n $SLURM_NTASKS ./microsim_kks_fd_cuda_mpi Input.in Filling.in Output
