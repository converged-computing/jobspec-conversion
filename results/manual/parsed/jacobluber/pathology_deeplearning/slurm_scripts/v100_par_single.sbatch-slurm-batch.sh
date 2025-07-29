#!/bin/bash
#SBATCH --output=/home/luberjm/pl/code/benchmarking/bw_d.out
#SBATCH --error=/home/luberjm/pl/code/benchmarking/bw_d.out
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:v100x:1
#SBATCH --mem=30gb
#SBATCH --time=15:00:00
#SBATCH --constraint=gpuv100x,ntasks-per-node=1

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
srun python /home/luberjm/pl/code/adjustments2.py --batch-size 64 --epochs 10 --gpus 1 --nodes 4 --workers 8 --custom-coords-file /home/luberjm/pl/code/patch_coords.data --accelerator ddp --logging-name bw_d --train-size 500000 --test-size 33500 --enc-dim 2048 --latent-dim 1024  --resnet resnet50 --read-coords || fail "python fail"
