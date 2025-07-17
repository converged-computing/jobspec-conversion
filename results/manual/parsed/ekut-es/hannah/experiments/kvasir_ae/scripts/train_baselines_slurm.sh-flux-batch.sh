#!/bin/bash
#FLUX: --job-name=kvasir_ae
#FLUX: --queue=gpu-2080ti
#FLUX: -t=43200
#FLUX: --urgency=16

export HANNAH_DATA_FOLDER='/mnt/qb/datasets/STAGING/bringmann/datasets/'
export EXPERIMENT='baseline'
export RESOLUTION='320'
export MODEL='timm_resnet152'

echo "Job information"
scontrol show job $SLURM_JOB_ID
export HANNAH_DATA_FOLDER=/mnt/qb/datasets/STAGING/bringmann/datasets/
export EXPERIMENT=baseline
export RESOLUTION=320
export MODEL=timm_resnet152
while [[ $# -gt 0 ]]; do
  case $1 in
    -m|--model)
      MODEL="$2"
      shift # past argument
      shift # past value
      ;;
    -r|--resolution)
      RESOLUTION="$2"
      shift # past argument
      shift # past value
      ;;
    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done
hannah-train experiment_id=${EXPERIMENT}_${RESOLUTION} module.num_workers=8 module.batch_size=32 trainer=sharded trainer.gpus=4 dataset.resolution=$RESOLUTION model=${MODEL}
