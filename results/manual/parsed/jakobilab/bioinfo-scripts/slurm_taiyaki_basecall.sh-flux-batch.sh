#!/bin/bash
#FLUX: --job-name=bloated-milkshake-3364
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
module load taiyaki
if [ ! $# == 3 ]; then
  echo "Usage: $0 [READ dir] [TRAIN dir] [OUT dir]"
  exit
fi
reads=$1
out=$3
train=$2
basecall.py --alphabet ACGT --device cuda:0 --modified_base_output $out/basecalls.hdf5 $reads $train/training2/model_final.checkpoint > $out/basecalls.fa
