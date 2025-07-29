#!/bin/bash
#SBATCH --job-name=gpus
#SBATCH --output=/ukp-storage-1/zhang/slurm_logs/gpu-a180-%j.out
#SBATCH --mail-user=hao.zhang@stud.tu-darmstadt.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --partition=yolo
#SBATCH --qos=yolo
#SBATCH --constraint=gpu_model:a180

source activate /mnt/beegfs/work/zhang/conda/dragon
module purge
module load cuda/11.0 # you can change the cuda version
nvidia-smi
