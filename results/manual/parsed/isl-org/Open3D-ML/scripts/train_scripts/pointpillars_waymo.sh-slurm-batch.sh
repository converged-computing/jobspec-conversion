#!/bin/bash
#SBATCH --job-name=objdet_2x4
#SBATCH --output=./slurm-%x-%j-%N.log
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --gres=gpu:4
#SBATCH --mem=384G
#SBATCH --constraint=ntasks-per-node=1

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
