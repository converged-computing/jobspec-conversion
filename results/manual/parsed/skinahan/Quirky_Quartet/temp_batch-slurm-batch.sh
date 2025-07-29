#!/bin/bash
#SBATCH --job-name=tune_t5_codexglue
#SBATCH --output=/scratch/lsaldyt/experiments/tune_t5_codexglue/%j.out
#SBATCH --error=/scratch/lsaldyt/experiments/tune_t5_codexglue/%j.err
#SBATCH --mail-user=lsaldyt@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:1
#SBATCH --time=7-00:00:00
#SBATCH --constraint=V100

export INCLUDEPATH='$INCLUDEPATH:$HOME/cuda/include'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$HOME/cuda/lib64'

module load cuda/11.6.0
module load rclone/1.43
module load blas/3.7.0
module load OpenBLAS/0.3.19
export INCLUDEPATH=$INCLUDEPATH:$HOME/cuda/include
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/cuda/lib64
echo "Running!
"
env
module list
nvcc --version
nvidia-smi
./run tune_t5_codexglue 
