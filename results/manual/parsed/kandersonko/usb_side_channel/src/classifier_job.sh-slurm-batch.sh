#!/bin/bash
#SBATCH --job-name=classifier-job
#SBATCH --output=jobs/cls_%A_%a.stdout
#SBATCH --error=jobs/cls_%A_%a.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a6000:2
#SBATCH --time=02:00:00
#SBATCH --partition=gpu-8

cd $SLURM_SUBMIT_DIR
echo "JOB timestamp: $(date)"
echo "JOB ID: $SLURM_JOB_ID"
hostname
source ~/.bashrc
nvidia-smi -L
conda activate usb2
python --version
which python
unset LD_LIBRARY_PATH
srun python classifier.py --log --method=tsfresh --dataset=dataset_a --target_label=category --classifier=lstm --task=identification --batch_size=32
