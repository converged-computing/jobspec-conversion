#!/bin/bash
#FLUX: --job-name=aesthetic
#FLUX: -N=8
#FLUX: --queue=g40
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:/fsx/zacliu/AltTools/Altdiffusion/src'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

source /fsx/zacliu/altclip_env/bin/activate
export PYTHONPATH=$PYTHONPATH:/fsx/zacliu/AltTools/Altdiffusion/src
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
srun python -u /fsx/zacliu/AltTools/Altdiffusion/src/scripts/train_hpc.py > /fsx/zacliu/AltTools/Altdiffusion/ckpt/laion_aethetics_all_512_xformer_ema_cfg/log.txt 2>&1
