#!/bin/bash
#SBATCH --job-name=Facke_cont_WO_intra-Id_random
#SBATCH --output=log.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=10-10:00:00
#SBATCH --partition=gpu

module load anaconda3/2019.07
source activate pytorch_1.11
python -u ./train_SimSwap.py --batchSize 32 --continue_train --epoch_label 1108511_iter --name SimSwap_WO_intra-ID_random --nThreads 32 --no_intra_ID_random
