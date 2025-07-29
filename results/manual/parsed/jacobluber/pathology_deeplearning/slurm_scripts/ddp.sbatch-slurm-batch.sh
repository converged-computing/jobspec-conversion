#!/bin/bash
#SBATCH --output=/home/luberjm/pl/code/benchmarking/par.out
#SBATCH --error=/home/luberjm/pl/code/benchmarking/par.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:k80:4
#SBATCH --mem=100gb
#SBATCH --time=00:20:00
#SBATCH --constraint=gpuk80,ntasks-per-node=4

export NCCL_DEBUG='INFO'
export NCCL_DEBUG_SUBSYS='COLL'
export NCCL_SOCKET_IFNAME='^docker0,lo'

function fail {
    echo "FAIL: $@" >&2
    exit 1  # signal failure
}
source /data/luberjm/conda/etc/profile.d/conda.sh || fail "conda load fail"
conda activate distrib || fail "conda activate fail"
module load nccl/2.7.8_cuda11.0
export NCCL_DEBUG=INFO
export NCCL_DEBUG_SUBSYS=COLL
export NCCL_SOCKET_IFNAME=^docker0,lo
G# -------------------------
srun python /home/luberjm/pl/code/experiment.py --batch-size 3 --epochs 2 --gpus 4 --nodes 2 --workers 32 --custom-coords-file /home/luberjm/pl/code/pc.data --accelerator ddp --logging-name par --train-size 1600 --test-size 400 --read-coords || fail "python fail"
