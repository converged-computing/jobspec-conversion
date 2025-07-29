#!/bin/bash
#SBATCH --output=jobs/tsfresh_%A.stdout
#SBATCH --error=jobs/tsfresh_%A.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=200G
#SBATCH --time=12:00:00
#SBATCH --partition=gpu-8
#SBATCH --constraint=ntasks-per-node=72

cd $SLURM_SUBMIT_DIR
echo "JOB timestamp: $(date)"
echo "JOB ID: $SLURM_JOB_ID"
hostname
source ~/.bashrc
conda activate usb
python --version
which python
srun python tsfresh_feature_engineering.py \
    --target_label=category --dataset_subset=test \
    --workers=92 --memory='2GB' --chunk_size=10
