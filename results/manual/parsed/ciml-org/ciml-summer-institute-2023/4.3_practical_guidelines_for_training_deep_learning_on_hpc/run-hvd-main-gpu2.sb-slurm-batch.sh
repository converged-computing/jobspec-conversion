#!/bin/bash
#FLUX: --job-name=tfhvd-gpu
#FLUX: -N=2
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=300
#FLUX: --urgency=16

export OMPI_MCA_btl='self,vader'
export UCX_TLS='shm,rc,ud,dc'
export UCX_NET_DEVICES='mlx5_0:1'
export UCX_MAX_RNDV_RAILS='1'

module reset
module load slurm  
module load gcc/10.2.0          #compiler, unix module  
module load openmpi/4.1.3       #mpi module
module load singularitypro/3.9  #container
module list
export OMPI_MCA_btl='self,vader'
export UCX_TLS='shm,rc,ud,dc'
export UCX_NET_DEVICES='mlx5_0:1'
export UCX_MAX_RNDV_RAILS=1
mpirun -n 8 singularity exec --bind /expanse,/scratch --nv /cm/shared/apps/containers/singularity/tensorflow/tensorflow-latest.sif python3 ./CIML23_MNIST_wHVD_exercise.py > stdout-gpu2x4.txt
