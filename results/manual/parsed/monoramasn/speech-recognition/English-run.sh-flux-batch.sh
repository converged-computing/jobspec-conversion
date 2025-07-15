#!/bin/bash
#FLUX: --job-name=large
#FLUX: -c=8
#FLUX: -t=41400
#FLUX: --urgency=16

echo $SLURMD_NODENAME $CUDA_VISIBLE_DEVICES
. /etc/profile.d/modules.sh
eval "$(conda shell.bash hook)"
nvidia-smi
conda activate /home/nkx870/anaconda3/envs/monorama
for language in en
do
    python3.9 English.py --language $language --model_size large
done
