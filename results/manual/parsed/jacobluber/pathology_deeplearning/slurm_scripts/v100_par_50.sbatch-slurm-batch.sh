#!/bin/bash
#SBATCH --output=/home/luberjm/pl/code/benchmarking/bw50_v.out
#SBATCH --error=/home/luberjm/pl/code/benchmarking/bw50_v.out
#SBATCH --nodes=6
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:v100x:4
#SBATCH --mem=100gb
#SBATCH --time=10:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=gpuv100x,ntasks-per-node=4

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
srun python /home/luberjm/pl/code/adjustments.py --batch-size 32 --epochs 15 --gpus 4 --nodes 6 --workers 32 --custom-coords-file /home/luberjm/pl/code/patch_coords.data --accelerator ddp --logging-name bw50_v --train-size 500000 --test-size 33500 --enc-dim 2048 --latent-dim 1024  --resnet resnet50 --read-coords || fail "python fail"
