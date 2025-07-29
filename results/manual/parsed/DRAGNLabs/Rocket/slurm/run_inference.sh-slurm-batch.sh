#!/bin/bash
#SBATCH --job-name=llama_inference
#SBATCH --output=%x_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=512G
#SBATCH --time=1-16:00:00
#SBATCH --qos=dw87

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
nvidia-smi
mamba activate rocket
python3 ../inference.py ../configs/PATH_TO_CONFIG.yaml
