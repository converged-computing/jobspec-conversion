#!/bin/bash
#FLUX: --job-name=loopy-frito-7596
#FLUX: -N=4
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=1200
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
G# -------------------------
srun python /home/luberjm/pl/code/experiment.py --batch-size 4 --epochs 2 --gpus 1 --nodes 4 --workers 8 --custom-coords-file /home/luberjm/pl/code/pc.data --accelerator ddp --logging-name v100x_4nodes_4gpus_32bit --train-size 1600 --test-size 400 --read-coords || fail "python fail"
