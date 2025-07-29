#!/bin/bash
#SBATCH --job-name=nbody_benchmark
#SBATCH --account=ftb@gpu
#SBATCH --output=nbody_benchmark%j.out
#SBATCH --error=nbody_benchmark%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:4
#SBATCH --time=00:10:00
#SBATCH --qos=qos_gpu-dev
#SBATCH --constraint=ntasks-per-node=4

module purge
module load tensorflow-gpu/py3/2.4.1+nccl-2.8.3-1
set -x
srun /gpfslocalsup/pub/idrtools/bind_gpu.sh python mesh_nbody_benchmark.py --nc=512 --batch_size=1 --nx=4 --ny=4 --hsize=32
