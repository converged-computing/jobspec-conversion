#!/bin/bash
#SBATCH --job-name=Facke_nFM
#SBATCH --output=log.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=10-10:00:00

module load anaconda3/2019.07
source activate pytorch_1.11
python -u ./train_SimSwap.py --batchSize 32 --nThreads 32 --name SimSwap_nFM --no_ganFeat_loss
