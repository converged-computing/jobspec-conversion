#!/bin/bash
#FLUX: --job-name=wmt-en2de
#FLUX: -c=40
#FLUX: -t=252000
#FLUX: --urgency=16

module purge
module load anaconda-py3/2019.03
conda activate lmvsseq2seq
set -x
nvidia-smi
srun accelerate launch --multi_gpu train_enc_dec_mp.py --train=True --test=True
