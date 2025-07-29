#!/bin/bash
#SBATCH --output=PGD_attack.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=2-00:00:00

date
echo "Slurm nodes: $SLURM_JOB_NODELIST"
NUM_GPUS=`echo $GPU_DEVICE_ORDINAL | tr ',' '\n' | wc -l`
echo "You were assigned $NUM_GPUS gpu(s)"
module load cuda/cuda-10.0
source activate pytorch-gpu
module list
nvidia-smi topo -m
echo
echo
time python validation.py
echo
echo "Ending script..."
date
