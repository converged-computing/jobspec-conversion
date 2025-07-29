#!/bin/bash
#SBATCH --job-name=gpu-hicoo
#SBATCH --account=soc-gpu-kp
#SBATCH --output=slurm-%j-dense.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=60G
#SBATCH --time=04:00:00
#SBATCH --qos=soc-gpu-kp
#SBATCH --constraint=ntasks-per-node=1

echo $0
echo
ulimit -c unlimited -s
module load cuda
nvidia-smi
echo VISIBLE === $CUDA_VISIBLE_DEVICES
./HiCooExperiment 8      4
./HiCooExperiment 1024   8 dense-32x32x32
./HiCooExperiment 16384                           # cpu is ok
./HiCooExperiment 16384  8 dense-256x256x256d.1   NOCPU # takes forever to do dense
./HiCooExperiment 16384  8 dense-128x128x128d.1   
echo TESTS COMPLETED
