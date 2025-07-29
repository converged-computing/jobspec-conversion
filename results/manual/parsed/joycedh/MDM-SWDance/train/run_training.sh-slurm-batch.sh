#!/bin/bash
#FLUX: --job-name=train-mdm-new
#FLUX: -n=4
#FLUX: -c=2
#FLUX: --queue=gpu-long
#FLUX: -t=86400
#FLUX: --urgency=16

export PYTHONPATH='.":$PYTHONPATH'

echo "## Starting MDM run on $HOSTNAME"
DIR=$(pwd)
echo "## Current directory $DIR"
echo "## using python:"
which python
export PYTHONPATH=".":$PYTHONPATH
echo "## Number of available CUDA devices: $CUDA_VISIBLE_DEVICES"
echo "## Checking status of CUDA device with nvidia-smi"
nvidia-smi
echo "## Running training"
CHECKPOINT=/motion-diffusion-model/save/humanml_trans_enc_512/model000200000.pt
SAVEDIR=/motion-diffusion-model/save/swdance/models
python train/train_mdm.py --save_dir=${SAVEDIR} --dataset=swdance \
    --resume_checkpoint=${CHECKPOINT} --overwrite \
    --save_interval=5000 --log_interval=500 \
    # --freeze_layers=0
