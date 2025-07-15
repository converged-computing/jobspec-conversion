#!/bin/bash
#FLUX: --job-name=red-chip-5577
#FLUX: --priority=16

export MASTER_PORT='$MASTER_PORT'
export MASTER_ADDR='$MASTER_ADDR'
export MIOPEN_USER_DB_PATH='/tmp/${USER}-miopen-cache-${SLURM_JOB_ID}'
export MIOPEN_CUSTOM_CACHE_DIR='${MIOPEN_USER_DB_PATH}'
export MIOPEN_DEBUG_CONV_IMPLICIT_GEMM='0'

for i in "$@"; do
  case $i in
    -n=*|--now=*)
      NOW="${i#*=}"
      shift # past argument=value
      ;;
    -*|--*)
      echo "Unknown option $i"
      exit 1
      ;;
    *)
      ;;
  esac
done
set -e
MASTER_ADDR=`/bin/hostname -s`
if (( $SLURM_JOB_NUM_NODES > 1 )); then
    WORKERS=`scontrol show hostnames $SLURM_JOB_NODELIST | grep -v $MASTER_ADDR`
fi
MASTER_PORT=`comm -23 <(seq 49152 65535 | sort) <(ss -Htan | awk '{print $4}' | cut -d':' -f2 | sort -u) | shuf | head -n 1`
export MASTER_PORT=$MASTER_PORT
export MASTER_ADDR=$MASTER_ADDR
echo "MASTER_ADDR" $MASTER_ADDR "MASTER_PORT" $MASTER_PORT "WORKERS" $WORKERS
export MIOPEN_USER_DB_PATH=/tmp/${USER}-miopen-cache-${SLURM_JOB_ID}
export MIOPEN_CUSTOM_CACHE_DIR=${MIOPEN_USER_DB_PATH}
export MIOPEN_DEBUG_CONV_IMPLICIT_GEMM=0
echo "MIOPEN_DEBUG_CONV_IMPLICIT_GEMM: " $MIOPEN_DEBUG_CONV_IMPLICIT_GEMM
source $PROJAPPL/miniconda3/etc/profile.d/conda.sh
conda activate synchformer
DATASET="dataset.audioset.AudioSet" VIDS_PATH="/scratch/project_462000293/vladimir/data/audioset/h264_video_25fps_256side_16000hz_aac/"
srun python main.py \
    start_time="$NOW" \
    config="./configs/segment_avclip.yaml" \
    data.vids_path="$VIDS_PATH" \
    data.dataset.target="$DATASET" \
    training.num_workers=7 \
    logging.logdir="$SCRATCH/vladimir/logs/sync/avclip_models" \
    logging.use_wandb=True
