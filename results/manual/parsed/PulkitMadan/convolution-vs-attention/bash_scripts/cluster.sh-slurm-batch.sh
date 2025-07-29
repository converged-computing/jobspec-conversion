#!/bin/bash
#FLUX: --job-name=refactoring_test
#FLUX: -c=4
#FLUX: -t=169200
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'

git clone https://github.com/PulkitMadan/convolution-vs-attention.git
rsync --bwlimit=10mb -av convolution-vs-attention ~/scratch/code-snapshots/ --exclude .git 
rm -r convolution-vs-attention
rsync -av --relative "$1" $SLURM_TMPDIR --exclude ".git"
cd $SLURM_TMPDIR/"$1/src"
module purge
module load StdEnv/2020
module load python/3.9.6
export PYTHONUNBUFFERED=1
virtualenv $SLURM_TMPDIR/venv
source $SLURM_TMPDIR/venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r ../requirements_cluster.txt
echo "Currently using:"
echo $(which python)
echo "in:"
echo $(pwd)
echo "sbatch file name: $0"
echo $(python -V)
echo $(pip3 show torch)
cp ~/scratch/code-snapshots/convolution-vs-attention/src/utils/helpers.py $SLURM_TMPDIR/venv/lib/python3.9/site-packages/timm/models/layers/helpers.py
wandb login $WANDB_API_KEY
python train.py --train --model resnet --pretrain --name refactored_resnet_test_run --frozen
python train.py --model resnet --pretrain --load
