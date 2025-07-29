#!/bin/bash
#SBATCH --account=nesi99991
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=8GB
#SBATCH --time=00:10:00
#SBATCH --partition=hgx

nvidia-smi
echo "CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES}"
module purge
module load TensorFlow/2.13.0-gimkl-2022a-Python-3.11.3
python train_model.py "${SLURM_JOB_ID}_${SLURM_JOB_NAME}"
