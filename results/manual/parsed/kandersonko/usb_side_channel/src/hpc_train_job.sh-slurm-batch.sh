#!/bin/bash
#SBATCH --output=jobs/sweep_%A_%a.stdout
#SBATCH --error=jobs/sweep_%A_%a.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00

cd $SLURM_SUBMIT_DIR
echo "JOB timestamp: $(date)"
echo "JOB ID: $SLURM_JOB_ID"
hostname
source ~/.bashrc
conda activate usb
python --version
which python
module load cuda/11.8
nvidia-smi -L
unset LD_LIBRARY_PATH
srun python train.py --min_epochs=10 --max_epochs=500 --batch_size=512 --target_label=class --num_classes=2
