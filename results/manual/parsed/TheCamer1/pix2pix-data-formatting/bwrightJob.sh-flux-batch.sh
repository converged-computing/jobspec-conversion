#!/bin/bash
#FLUX: --job-name=MRtoCT
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

module load python/3.9.15
VENV_PATH="$HOME/.virtualenvs/MRCT"
if [ ! -d "$VENV_PATH" ]; then
    python -m venv "$VENV_PATH"
fi
source "$VENV_PATH/bin/activate"
pip install --upgrade pip
pip install torch torchvision torchaudio --extra-index-url http://download.pytorch.org/whl/cu118 --trusted-host download.pytorch.org
pip install dominate
pip install visdom
pip install wandb
python -m train.py --dataroot /rds/PRJ-BWsCT/FormattedFinal --name MRtoCT_pix2pix --model pix2pix --direction AtoB
