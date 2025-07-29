#!/bin/bash
#SBATCH --job-name=tfhvd-gpu
#SBATCH --account=use300
#SBATCH --output=slurm.gpu2x4.%x.o%j.%N.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=4
#SBATCH --mem=368G
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=4

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
