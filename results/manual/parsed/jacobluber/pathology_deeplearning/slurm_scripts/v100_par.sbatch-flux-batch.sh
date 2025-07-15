#!/bin/bash
#FLUX: --job-name=boopy-lemur-9475
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
srun python /home/luberjm/pl/code/adjustments.py --batch-size 32 --epochs 15 --gpus 4 --nodes 6 --workers 32 --custom-coords-file /home/luberjm/pl/code/patch_coords.data --accelerator ddp --logging-name bw18 --train-size 500000 --test-size 33500 --enc-dim 512 --latent-dim 256  --resnet resnet18 --read-coords || fail "python fail"
