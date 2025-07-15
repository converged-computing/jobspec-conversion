#!/bin/bash
#FLUX: --job-name=objdet_2x4
#FLUX: -N=2
#FLUX: -c=48
#FLUX: --urgency=16

export PRIMARY_ADDR='${PRIMARY_ADDR:-$SLURMD_NODENAME}'
export PRIMARY_PORT='${PRIMARY_PORT:-29500}'
export DEVICE_IDS='${DEVICE_IDS:-$(nvidia-smi --list-gpus | cut -f2 -d' ' | tr ':\n' ' ')}'
export NODE_RANK='${NODE_RANK:-SLURM_NODEID} # Pass name of env var'

if [ "$#" -ne 2 ]; then
    echo "Please, provide the training framework: torch/tf and dataset path."
    exit 1
fi
export PRIMARY_ADDR=${PRIMARY_ADDR:-$SLURMD_NODENAME}
export PRIMARY_PORT=${PRIMARY_PORT:-29500}
export DEVICE_IDS=${DEVICE_IDS:-$(nvidia-smi --list-gpus | cut -f2 -d' ' | tr ':\n' ' ')}
export NODE_RANK=${NODE_RANK:-SLURM_NODEID} # Pass name of env var
echo Started at: $(date)
pushd ../..
srun -l python scripts/run_pipeline.py "$1" -c ml3d/configs/pointpillars_waymo.yml \
    --dataset_path "$2" --pipeline ObjectDetection \
    --pipeline.num_workers 0 --pipeline.pin_memory False \
    --pipeline.batch_size 4 --device_ids $DEVICE_IDS \
    --backend nccl \
    --nodes $SLURM_JOB_NUM_NODES \
    --node_rank "$NODE_RANK" \
    --host "$PRIMARY_ADDR" --port "$PRIMARY_PORT"
echo Completed at: $(date)
popd
