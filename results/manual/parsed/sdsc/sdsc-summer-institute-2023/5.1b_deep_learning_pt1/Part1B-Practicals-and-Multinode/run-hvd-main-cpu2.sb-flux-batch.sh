#!/bin/bash
#FLUX: --job-name=tfhvd-cpu
#FLUX: -N=2
#FLUX: --queue=compute
#FLUX: -t=900
#FLUX: --priority=16

export OMPI_MCA_btl='self,vader'
export UCX_TLS='shm,rc,ud,dc'
export UCX_NET_DEVICES='mlx5_0:1'
export UCX_MAX_RNDV_RAILS='1'

module reset
module load slurm  
module load gcc/10.2.0          #compiler, unix   
module load openmpi/4.1.3       #open mpi       
module load singularitypro/3.9  #container      
module list
export OMPI_MCA_btl='self,vader'
export UCX_TLS='shm,rc,ud,dc'
export UCX_NET_DEVICES='mlx5_0:1'
export UCX_MAX_RNDV_RAILS=1
mpirun -n ${SLURM_NTASKS} singularity exec --bind /expanse,/scratch /cm/shared/apps/containers/singularity/tensorflow/tensorflow-latest.sif python3 ./SI2023_MNIST_wHVD_solution.py > stdout_cpu2_mnist_${SLURM_NTASKS}.txt
