#!/bin/bash
#SBATCH --job-name=train
#SBATCH --output=outputs/train_%A.out
#SBATCH --error=outputs/train_%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=20GB
#SBATCH --time=20:00:00

module purge
module load python3/intel/3.5.3
module load pytorch/python3.5/0.2.0_3
module load torchvision/python3.5/0.1.9
python3 -u /scratch/sb3923/time_series/EarlySepsisPrediction/RNN-missingval/train.py --experiment 'seq12_mask' --seqlen 12 --predlen 0 --mask 
