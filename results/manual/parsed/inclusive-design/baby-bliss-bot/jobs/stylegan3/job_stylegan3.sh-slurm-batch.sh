#!/bin/bash
#FLUX: --job-name=stylegan3
#FLUX: -t=2073600
#FLUX: --urgency=16

export CUDA_LAUNCH_BLOCKING='1'

pip install --no-index --upgrade pip
module load python/3.8.2
python -V
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
module load scipy-stack/2021a
module load cuda/11.1.1
nvcc -V
which gcc
pip install -r ~/stylegan3/stylegan3/requirements.txt
pip list
export CUDA_LAUNCH_BLOCKING=1
echo "Hello from job $SLURM_JOB_ID on nodes $SLURM_JOB_NODELIST."
python ~/stylegan3/stylegan3/train.py --outdir=~/stylegan3/training-runs --cfg=stylegan3-r --data=~/stylegan3/datasets/bliss-256x256.zip --gpus=1 --batch=32 --gamma=2 --batch-gpu=8 --snap=10
