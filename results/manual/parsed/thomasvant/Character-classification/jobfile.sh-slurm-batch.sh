#!/bin/bash
#SBATCH --job-name=elmo
#SBATCH --output=/home/nfs/tvantussenbroe/NLP_project/Character-classification/output.txt
#SBATCH --error=/home/nfs/tvantussenbroe/NLP_project/Character-classification/errors.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0
#SBATCH --mem=10000
#SBATCH --time=04:00:00
#SBATCH --partition=general
#SBATCH --qos=short
#SBATCH --chdir=/home/nfs/tvantussenbroe/NLP_project/Character-classification

module use /opt/insy/modulefiles
module load cuda/10.1 cudnn/10.1-7.6.0.64
source ~/NLP_project/Character-classification/venv/bin/activate
echo "Starting at $(date)"
srun python main.py
echo "Finished at $(date)"
