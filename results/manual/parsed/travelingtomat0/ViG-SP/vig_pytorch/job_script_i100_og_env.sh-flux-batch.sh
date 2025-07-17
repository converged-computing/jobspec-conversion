#!/bin/bash
#FLUX: --job-name=arid-leopard-1647
#FLUX: --urgency=16

set -o errexit
mkdir /scratch/mateodi/run_folder/$SLURM_JOB_ID/
TMPDIR=/scratch/mateodi/run_folder/$SLURM_JOB_ID/
if [[ ! -d ${TMPDIR} ]]; then
    echo 'Failed to access directory' >&2
    exit 1
fi
trap "exit 1" HUP INT TERM
export TMPDIR
cd "${TMPDIR}" || exit 1
echo "Running on node: $(hostname)"
echo "In directory:    $(pwd)"
echo "Starting on:     $(date)"
echo "SLURM_JOB_ID:    ${SLURM_JOB_ID}"
python -m torch.distributed.launch --nproc_per_node=1 /itet-stor/mateodi/net_scratch/mod_vig_pytorch/vig_pytorch/train.py /scratch/mateodi/imagenet-100/ --model sp_vig --sched cosine --epochs 2 --opt adamw -j 1 --num-classes 100 --warmup-lr 1e-6 --mixup .8 --cutmix 1.0 --model-ema --model-ema-decay 0.99996 --aa rand-m9-mstd0.5-inc1 --color-jitter 0.4 --warmup-epochs 20 --opt-eps 1e-8 --repeated-aug --remode pixel --reprob 0.25 --amp --lr 2e-3 --weight-decay .05 --drop 0 --drop-path .1 -b 16 --output /itet-stor/mateodi/superpixel_gnns/outputs/
echo "Finished at:     $(date)"
exit 0
