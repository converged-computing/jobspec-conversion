#!/bin/bash
#SBATCH --job-name=training-run-continue
#SBATCH --mail-user=email@example.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:k40:2
#SBATCH --mem=40GB
#SBATCH --time=1-00:00:00

STYLEGAN_PATH=/your/path/to/stylegan
module load TensorFlow/1.10.1-fosscuda-2018a-Python-3.6.4
cd $STYLEGAN_PATH
source venv/bin/activate
srun python train.py
