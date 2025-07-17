#!/bin/bash
#FLUX: --job-name=test_mistral
#FLUX: --queue=gpu_a100_8
#FLUX: -t=630
#FLUX: --urgency=16

spack load anaconda3@2022.05
conda init bash
eval "$(conda shell.bash hook)"
conda activate /home/prajna/.conda/envs/mistral
cd /home/prajna/mistral_finetune
python finetune_02.py
