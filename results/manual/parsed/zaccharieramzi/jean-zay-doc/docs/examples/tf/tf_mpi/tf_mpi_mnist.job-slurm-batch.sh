#!/bin/bash
#SBATCH --job-name=mnist_tf_mpi
#SBATCH --account=changeme@gpu
#SBATCH --output=mnist_tf_mpi_log_%j.out
#SBATCH --error=mnist_tf_mpi_log_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:4
#SBATCH --time=00:01:00
#SBATCH --partition=gpu_p1
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=4

cd ${SLURM_SUBMIT_DIR}
module purge
module load cudnn/10.1-v7.5.1.10
module load nccl/2.4.2-1+cuda10.1
module load tensorflow-gpu/py3/1.14-openmpi
set -x
srun --mpi=pmix python tf_mpi_mnist.py --mnist $PWD/mnist.npz
