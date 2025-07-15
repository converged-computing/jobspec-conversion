#!/bin/bash
#FLUX: --job-name=chocolate-diablo-0747
#FLUX: --urgency=16

module load miniconda3/23.11.0s
source /oscar/runtime/software/external/miniconda3/23.11.0/etc/profile.d/conda.sh
conda activate rt1_pytorch2
cd rt1-pytorch
python main.py --datasets bridge --train-split "train[:500]" --eval-split "train[:500]" --train-batch-size 8 --eval-batch-size 8 --eval-freq 100 --checkpoint-freq 100 --checkpoint-dir /users/sjulian2/data/sjulian2/rt1-pytorch/checkpoints/bridge --load-checkpoint /users/sjulian2/data/sjulian2/rt1-pytorch/checkpoints/bridge/checkpoint_14400_loss_70.621.pt
echo $PATH
