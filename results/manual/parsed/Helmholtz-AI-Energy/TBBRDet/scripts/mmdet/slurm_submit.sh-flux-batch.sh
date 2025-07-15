#!/bin/bash
#FLUX: --job-name=outstanding-snack-4485
#FLUX: --exclusive
#FLUX: --queue=<add your partition>
#FLUX: -t=18000
#FLUX: --priority=16

export NCCL_IB_TIMEOUT='30'
export SHARP_COLL_LOG_LEVEL='3'
export OMPI_MCA_coll_hcoll_enable='0'
export NCCL_SOCKET_IFNAME='ib0'
export NCCL_COLLNET_ENABLE='0'
export NCCL_DEBUG_SUBSYS='INIT,GRAPH'

if [[ "$#" -ne 2 ]]; then
        echo "Illegal number of parameters"
        echo "Usage: $0 <config file> <seed>"
        exit 1
fi
if [ ! -f "$1" ]; then
        echo "$1 does not exist."
        echo "Usage: $0 <config file> <seed>"
        exit 1
fi
echo "Config file: $1";
echo "Random seed: $2";
SRUN_PARAMS=(
  --mpi="pmi2"
  --label
  --cpus-per-task=16
  --unbuffered
)
export NCCL_IB_TIMEOUT=30
export SHARP_COLL_LOG_LEVEL=3
export OMPI_MCA_coll_hcoll_enable=0
export NCCL_SOCKET_IFNAME="ib0"
export NCCL_COLLNET_ENABLE=0
export NCCL_DEBUG_SUBSYS="INIT,GRAPH"
source /path/to/python/venv
srun "${SRUN_PARAMS[@]}" \
    python ~/Wahn/scripts/mmdet/train.py \
    --launcher="slurm" \
    --seed $2 \
    --deterministic \
    $1
