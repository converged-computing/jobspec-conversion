#!/bin/bash
#SBATCH --job-name=arrayjob-readline
#SBATCH --output=%x-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --mem-per-cpu=32G
#SBATCH --time=1-00:00:00
#SBATCH --array=1-35

module load python/3.9.0
module load gcc/10.2
module load cuda/11.7.1
module load cudnn/8.2.0
source ./venv/bin/activate
dataFile="`sed -n ${SLURM_ARRAY_TASK_ID}p gansTrainingFiles.txt`"
python gan_training_main.py ddp filter_generator path_dataset="${dataFile}" n_epochs=8000
