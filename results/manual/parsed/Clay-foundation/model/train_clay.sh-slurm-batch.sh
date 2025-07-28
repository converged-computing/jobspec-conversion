#!/bin/bash
#FLUX: --job-name=train_clay_v0.3.5
#FLUX: -N=2
#FLUX: --queue=g4-queue
#FLUX: -t=7200
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'
export PYTHONUNBUFFERED='1'

eval "$(conda 'shell.bash' 'hook' 2> /dev/null)"
conda activate claymodel
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
export PYTHONUNBUFFERED=1
srun python trainer.py fit --model ClayMAEModule --data ClayDataModule --config configs/config.yaml --data.data_dir /fsx
