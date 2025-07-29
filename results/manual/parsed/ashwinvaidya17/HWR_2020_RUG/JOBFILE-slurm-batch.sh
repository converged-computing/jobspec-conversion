#!/bin/bash
#SBATCH --job-name=HWR-Group5
#SBATCH --output=HWR_ConsoleLog
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=8GB
#SBATCH --time=05:00:00

module load Python/3.7.4-GCCcore-8.3.0
module load TensorFlow/2.1.0-fosscuda-2019b-Python-3.7.4
python -m pip install -r requirements.txt --user
python ./main.py --image ./test_images
