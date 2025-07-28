#!/bin/bash
#FLUX: --job-name=6mer_Non_overlaping_pretrain_4_6_BERT_test_data_1e6
#FLUX: -t=3540
#FLUX: --urgency=16

module purge
module load CUDA/11.8.0
source ~/miniconda3/etc/profile.d/conda.sh
conda activate bert_shinhan
cd /mnt/home/tangji19/DNABERT/BERT
python Pretrain_6mer.py
scontrol show job $SLURM_JOB_ID
