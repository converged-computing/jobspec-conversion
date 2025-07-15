#!/bin/bash
#FLUX: --job-name=train
#FLUX: -c=2
#FLUX: -t=72000
#FLUX: --priority=16

module purge
module load python3/intel/3.5.3
module load pytorch/python3.5/0.2.0_3
module load torchvision/python3.5/0.1.9
python3 -u /scratch/sb3923/time_series/EarlySepsisPrediction/RNN-missingval/train.py --experiment 'seq12_mask' --seqlen 12 --predlen 0 --mask 
