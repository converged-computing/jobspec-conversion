#!/bin/bash
#SBATCH --output=slurm_output/slurm.%N.%j.out
#SBATCH --error=slurm_output/slurm.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:01:00
#SBATCH --partition=dgx2q

ulimit -s 10240
mkdir -p ~/output/g001
module purge
module load slurm/20.02.7
module load cuda11.2/blas/11.2.2
module load cuda11.2/fft/11.2.2
module load cuda11.2/nsight/11.2.2
module load cuda11.2/profiler/11.2.2
module load cuda11.2/toolkit/11.2.2
module load pytorch-extra-py37-cuda11.2-gcc8/1.9.1  
source $HOME/.venv/bin/activate
srun nvidia-smi
hostname
srun python3 /home/feliciaj/PolypSegmentation/src/deep_ensemble.py
