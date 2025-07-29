#!/bin/bash
#SBATCH --job-name=lidar_default
#SBATCH --output=jobs/%j.out
#SBATCH --error=jobs/%j.err
#SBATCH --mail-user=christoph.gerum@uni-tuebingen.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx2080ti:4
#SBATCH --time=12:00:00
#SBATCH --partition=gpu-2080ti

export HANNAH_DATA_FOLDER='/mnt/qb/datasets/STAGING/bringmann/datasets/'
export EXPERIMENT='baseline'
export RESOLUTION='320'
export MODEL='timm_resnet152'
export SPLIT='official'

echo "Job information"
scontrol show job $SLURM_JOB_ID
export HANNAH_DATA_FOLDER=/mnt/qb/datasets/STAGING/bringmann/datasets/
export EXPERIMENT=baseline
export RESOLUTION=320
export MODEL=timm_resnet152
export SPLIT=official
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
    --random)
      SPLIT=random
      shift
      ;;
    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done
hannah-train experiment_id=${EXPERIMENT}_${RESOLUTION}_${SPLIT} module.num_workers=8 module.batch_size=32 trainer=sharded trainer.gpus=4 dataset.split=${SPLIT} dataset.resolution=$RESOLUTION model=${MODEL}
