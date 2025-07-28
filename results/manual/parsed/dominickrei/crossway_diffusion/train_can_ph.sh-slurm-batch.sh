#!/bin/bash
#FLUX: --job-name=diffusion-policy-can_ph-crossway_vit-t_backbone
#FLUX: -c=16
#FLUX: --queue=GPU
#FLUX: -t=259200
#FLUX: --urgency=16

module load anaconda3
module load cuda
module list
conda init bash
source ~/.bashrc
conda activate robo
echo Active env: $CONDA_DEFAULT_ENV
echo $(nvidia-smi)
echo started running script
EGL_DEVICE_ID=0 python /users/dreilly1/Projects/robotics/crossway_diffusion/train.py --config-dir=config/can_ph/ --config-name=typea.yaml training.seed=42
echo finished running script
