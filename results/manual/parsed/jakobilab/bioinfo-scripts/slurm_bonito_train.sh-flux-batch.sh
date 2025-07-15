#!/bin/bash
#FLUX: --job-name=fat-plant-6467
#FLUX: --urgency=16

echo "==== Start of GPU information ===="
CUDA_DEVICE=$(echo "$CUDA_VISIBLE_DEVICES," | cut -d',' -f $((SLURM_LOCALID + 1)) );
T_REGEX='^[0-9]$';
if ! [[ "$CUDA_DEVICE" =~ $T_REGEX ]]; then
        echo "error no reserved gpu provided"
        exit 1;
fi
echo -e "SLURM job:\t$SLURM_JOBID"
echo -e "SLURM process:\t$SLURM_PROCID"
echo -e "SLURM GPU ID:\t$SLURM_LOCALID"
echo -e "CUDA_DEVICE ID:\t$CUDA_DEVICE"
echo -e "CUDA_VISIBLE_DEVICES:\t$CUDA_VISIBLE_DEVICES"
echo "Device list:"
echo "$(nvidia-smi --query-gpu=name,gpu_uuid --format=csv -i $CUDA_VISIBLE_DEVICES | tail -n +2)"
echo "==== End of GPU information ===="
echo ""
module unload cuda
module unload taiyaki
module unload guppy
module load cuda/9.2
module load bonito
if [ ! $# == 2 ]; then
  echo "Usage: $0 [Input dir] [Output dir]"
  exit
fi
INPUT=$1
OUTPUT=$2
bonito train --amp --multi-gpu --batch 200 $OUTPUT --config /biosw/bonito/0.2.3/lib/python3.6/site-packages/bonito/models/configs/quartznet5x5_ACGTY.toml --directory $INPUT
