#!/bin/bash
#FLUX: --job-name=MT
#FLUX: --queue=small
#FLUX: --urgency=16

module load cuda/9.2
echo $CUDA_VISIBLE_DEVICES
nvidia-smi
echo $PWD
python3 main_mt.py -m transformer -b 64  -d DE_EN -g 0 -layer 6 -emb 512  >slurm-Tfseq2seq-$SLURM_JOB_ID.out
