#!/bin/bash
#FLUX: --job-name=purple-mango-4861
#FLUX: -c=4
#FLUX: --queue=main
#FLUX: -t=86400
#FLUX: --priority=16

source ./open_lth/slurm-setup.sh cifar10
CKPT_ROOT=$HOME/scratch/open_lth_data/
BARRIER_ROOT=$HOME/scratch/2022-nnperm/sparse-to-sparse/
CKPT=(  \
    lottery_45792df32ad68649ffd066ae40be4868  \
)
REP_A=(1 3)
REP_B=(2 4)
KERNEL=(cosine)
        # --levels="2,6,10,14,18"  \
parallel --delay=15 --linebuffer --jobs=1  \
    python -m scripts.open_lth_barriers  \
        --repdir_a=$CKPT_ROOT/{1}/replicate_{2}/  \
        --repdir_b=$CKPT_ROOT/{1}/replicate_{3}/  \
        --train_ep_it="ep160_it0" \
        --levels="0"  \
        --save_file=$BARRIER_ROOT/{1}/replicate_{2}-{3}/"barrier-{4}-ep160.pt"  \
        --n_train=10000 \
        --kernel={4} \
    ::: ${CKPT[@]}  \
    ::: ${REP_A[@]}  \
    :::+ ${REP_B[@]}  \
    ::: ${KERNEL[@]}  \
