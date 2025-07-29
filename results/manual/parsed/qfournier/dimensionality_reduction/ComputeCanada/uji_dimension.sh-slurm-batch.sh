#!/bin/bash
#SBATCH --job-name=uji
#SBATCH --account=def-aloise
#SBATCH --output=/home/qfournie/logs/%x-%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:2
#SBATCH --mem=127000M
#SBATCH --time=1-00:00:00
#SBATCH --array=1,3,5,7,9,11,13,15,17,19,21,23,25,27,29

module load python/3.5
module load cuda/9.0
module load cudnn/7.0
source ~/keras-env/bin/activate
cd /home/qfournie/dimensionality_reduction
python3 main.py -d uji -t dimension -c knn --start_dim $SLURM_ARRAY_TASK_ID --n_dim 1
