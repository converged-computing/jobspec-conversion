#!/bin/bash
#FLUX: --job-name=bert2bert
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

my_job_header
/bin/hostname
module purge
module load python/3.10.4
module load pytorch
!pip install transformers bert-extractive-summarizer datasets evaluate rouge_score sacrebleu git-python==1.0.3
python3 train_bert2bert.py
