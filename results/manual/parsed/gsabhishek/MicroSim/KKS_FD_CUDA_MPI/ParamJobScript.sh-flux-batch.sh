#!/bin/bash
#FLUX: --job-name=psycho-malarkey-9394
#FLUX: -n=8
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

module load gcc/10.2.0 cuda spack gnu8 gsl
. /home/apps/spack/share/spack/setup-env.sh
spack load nvhpc
mpirun -n $SLURM_NTASKS ./microsim_kks_fd_cuda_mpi Input.in Filling.in Output
