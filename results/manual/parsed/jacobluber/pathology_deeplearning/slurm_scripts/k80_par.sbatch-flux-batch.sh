#!/bin/bash
#FLUX: --job-name=ornery-parsnip-4765
#FLUX: -N=6
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export NCCL_DEBUG_SUBSYS='COLL'
export NCCL_SOCKET_IFNAME='^docker0,lo'

function fail {
    echo "FAIL: $@" >&2
    exit 1  # signal failure
}
source /data/luberjm/conda/etc/profile.d/conda.sh || fail "conda load fail"
conda activate ml2 || fail "conda activate fail"
module load nccl/2.7.8_cuda11.0
export NCCL_DEBUG=INFO
export NCCL_DEBUG_SUBSYS=COLL
export NCCL_SOCKET_IFNAME=^docker0,lo
srun python /home/luberjm/pl/code/adjustments2.py --batch-size 32 --epochs 10 --gpus 4 --nodes 6 --workers 32 --custom-coords-file /home/luberjm/pl/code/patch_coords.data --accelerator ddp --logging-name bw_k80 --train-size 500000 --test-size 33500 --enc-dim 2048 --latent-dim 1024  --resnet resnet50 --read-coords || fail "python fail"
