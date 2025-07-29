#!/bin/bash
#FLUX: --job-name=vq2d_val
#FLUX: -c=6
#FLUX: -t=21600
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:$PYTRACKING_ROOT'

module purge
module load cuda/11.4.4
module load gcc
conda activate vq2d
VQ2D_ROOT=$PWD
TRAIN_ROOT=$VQ2D_ROOT/checkpoint/eccv_model
EVAL_ROOT=$VQ2D_ROOT/result/eccv_model
CLIPS_ROOT=$VQ2D_ROOT/data/clips
VQ2D_SPLITS_ROOT=$VQ2D_ROOT/data/vq_splits
PYTRACKING_ROOT=$VQ2D_ROOT/dependencies/pytracking
N_PART=100.0
ITER='0064999'
export PYTHONPATH="$PYTHONPATH:$VQ2D_ROOT"
export PYTHONPATH="$PYTHONPATH:$PYTRACKING_ROOT"
cd $VQ2D_ROOT
which python
sleep $((RANDOM%30+1))
python evaluate_vq2d.py \
  data.data_root="$CLIPS_ROOT" \
  data.split="val" \
  +data.part=$SLURM_ARRAY_TASK_ID \
  +data.n_part=$N_PART \
  data.annot_root="$VQ2D_SPLITS_ROOT" \
  data.num_processes=2 \
  data.rcnn_batch_size=4 \
  +signals.height=0.6 \
  model.config_path="$TRAIN_ROOT/output/config.yaml" \
  model.checkpoint_path="$TRAIN_ROOT/output/model_${ITER}.pth" \
  logging.save_dir="$EVAL_ROOT/model_${ITER}_kys/" \
  logging.stats_save_path="$EVAL_ROOT/model_${ITER}_kys/vq_stats_val_$SLURM_ARRAY_TASK_ID.json.gz" tracker.type='kys'
echo $EVAL_ROOT/model_${ITER}
  # signals.distance=5 signals.width=3 
