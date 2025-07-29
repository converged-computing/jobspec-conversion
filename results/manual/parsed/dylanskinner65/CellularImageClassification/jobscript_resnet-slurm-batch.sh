#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=120G
#SBATCH --time=05:00:00
#SBATCH --qos=cs

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'
export CUDA_LAUNCH_BLOCKING='1'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
export CUDA_LAUNCH_BLOCKING=1
mamba activate cic
python ~/CellularImageClassification/resnet_pretrained.py --t=5 --checkpoint_folder='resnet_checkpoints' -p=False
