#!/bin/bash
#FLUX: --job-name=quirky-poo-0990
#FLUX: -N=3
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

function fail {
    echo "FAIL: $@" >&2
    exit 1  # signal failure
}
source /data/luberjm/conda/etc/profile.d/conda.sh || fail "conda load fail"
conda activate ml2 || fail "conda activate fail"
srun python /home/luberjm/pl/code/small_patches.py --batch-size 32 --epochs 30 --gpus 2 --nodes 3 --workers 16 --custom-coords-file /home/luberjm/pl/code/patch_coords.data --accelerator ddp --logging-name small_patches_bw_normed_16 --train-size 500000 --test-size 33500 --enc-dim 2048 --latent-dim 16  --resnet resnet50 --read-coords || fail "python fail"
