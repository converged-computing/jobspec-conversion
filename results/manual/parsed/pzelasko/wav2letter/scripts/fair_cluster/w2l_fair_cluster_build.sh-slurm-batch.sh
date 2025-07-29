#!/bin/bash
#SBATCH --job-name=wav2letter-build
#SBATCH --output=/checkpoint/%u/jobs/wav2letter/build/wav2letter-build-%j.out
#SBATCH --error=/checkpoint/%u/jobs/wav2letter/build/wav2letter-build-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:volta:1
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=1

export CMAKE_PREFIX_PATH='$HOME/usr'

module purge
module load cuda/9.2
module load cudnn/v7.1-cuda.9.2
module load NCCL/2.2.13-1-cuda.9.2
module load mkl/2018.0.128
module load openmpi/3.0.0/gcc.6.3.0
module load kenlm/110617/gcc.6.3.0
export CMAKE_PREFIX_PATH="$HOME/usr"
cd "$HOME/wav2letter/build/" && cmake .. && make -j32
