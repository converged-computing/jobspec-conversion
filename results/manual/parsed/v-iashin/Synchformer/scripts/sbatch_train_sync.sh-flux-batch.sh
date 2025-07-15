#!/bin/bash
#FLUX: --job-name=moolicious-lamp-6501
#FLUX: --urgency=16

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
echo "MIOPEN_DEBUG_CONV_IMPLICIT_GEMM:" $MIOPEN_DEBUG_CONV_IMPLICIT_GEMM
source $PROJAPPL/miniconda3/etc/profile.d/conda.sh
conda activate synchformer
DATASET_TARGET="dataset.audioset.AudioSet" VIDS_PATH="/scratch/project_462000293/vladimir/data/audioset/h264_video_25fps_256side_16000hz_aac/"
CKPT_ID="xx-xx-xxTxx-xx-xx"
EPOCH="best"
srun python main.py \
    start_time="$NOW" \
    config="./configs/sync.yaml" \
    logging.logdir="$SCRATCH/vladimir/logs/sync/sync_models/" \
    logging.use_wandb=True \
    data.vids_path="$VIDS_PATH" data.dataset.target="$DATASET_TARGET" \
    model.params.vfeat_extractor.params.ckpt_path="$SCRATCH/vladimir/logs/sync/avclip_models/${CKPT_ID}/checkpoints/epoch_${EPOCH}.pt" \
    model.params.afeat_extractor.params.ckpt_path="$SCRATCH/vladimir/logs/sync/avclip_models/${CKPT_ID}/checkpoints/epoch_${EPOCH}.pt" \
    training.base_batch_size=16 \
    training.num_workers=7 \
    training.patience=10
