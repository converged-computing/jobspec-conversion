#!/bin/bash
#FLUX: --job-name=HopfieldLM
#FLUX: --queue=small
#FLUX: --urgency=16

module load cuda/9.2
echo $CUDA_VISIBLE_DEVICES
nvidia-smi
echo $PWD
python3 main.py -m lstm -b 128  -d 1mb -g 0 > slurm-lstmLM-1mb-$SLURM_JOB_ID.out
