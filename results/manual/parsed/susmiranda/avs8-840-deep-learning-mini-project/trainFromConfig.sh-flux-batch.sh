#!/bin/bash
#FLUX: --job-name=train_${1}
#FLUX: -t=57600
#FLUX: --urgency=16

sbatch <<EOT
echo "The config file used is KWT_configs/${1}.cfg"
srun --gres=gpu:1 singularity exec --nv ~/pytorch-24.01 python train.py --conf "KWT_configs/${1}.cfg"
EOT
