#!/bin/bash
#FLUX: --job-name=$1
#FLUX: --queue=gpu
#FLUX: -t=345600
#FLUX: --urgency=16

sbatch <<EOT
source ${HOME}/.bashrc
conda activate python3.7
set PYTHONPATH=./
python -m torch.distributed.launch --nproc_per_node=4 ./$1/Run.py --mode='$2' --data_path='$4' --dataset='$5'
EOT
