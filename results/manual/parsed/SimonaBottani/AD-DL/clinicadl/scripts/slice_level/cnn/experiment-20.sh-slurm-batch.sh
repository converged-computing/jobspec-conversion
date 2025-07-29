#!/bin/bash
#FLUX: --job-name=exp20_cnn
#FLUX: -c=32
#FLUX: --queue=gpu_p1
#FLUX: -t=324000
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate clinicadl_env_py37
SCRIPT="train_CNN_bad_data_split.py"
NETWORK="resnet18"
COHORT="ADNI"
DATE="reproducibility_results_2"
CAPS_DIR="$SCRATCH/../commun/datasets/${COHORT}_rerun"
TSV_PATH="$HOME/code/AD-DL/data/$COHORT/lists_by_diagnosis/train"
OUTPUT_DIR="$SCRATCH/results/$DATE/"
NUM_PROCESSORS=32
GPU=1
PREPROCESSING='linear'
DIAGNOSES="AD CN"
MRI_PLANE=0
SPLITS=5
SPLIT=$SLURM_ARRAY_TASK_ID
EPOCHS=50
BATCH=32
BASELINE=1
LR=1e-6
WEIGHT_DECAY=1e-4
PATIENCE=15
TOLERANCE=0
OPTIONS=""
if [ $GPU = 1 ]; then
OPTIONS="${OPTIONS} --gpu"
fi
if [ $BASELINE = 1 ]; then
echo "using only baseline data"
OPTIONS="$OPTIONS --baseline"
fi
NAME="slice2D_model-${NETWORK}_preprocessing-${PREPROCESSING}_task-AD-CN_baseline-${BASELINE}_preparedl-1_bad_split"
if [ $SPLITS > 0 ]; then
echo "Use of $SPLITS-fold cross validation, split $SPLIT"
NAME="${NAME}_splits-${SPLITS}"
fi
echo $NAME
python $HOME/code/AD-DL/clinicadl/clinicadl/slice_level/$SCRIPT \
  $CAPS_DIR \
  $TSV_PATH \
  $OUTPUT_DIR$NAME \
  --network $NETWORK \
  --batch_size $BATCH \
  --diagnoses $DIAGNOSES \
  --mri_plane $MRI_PLANE \
  --n_splits $SPLITS \
  --split $SPLIT \
  --epochs $EPOCHS \
  --learning_rate $LR \
  --weight_decay $WEIGHT_DECAY \
  --patience $PATIENCE \
  --tolerance $TOLERANCE \
  --prepare_dl \
  $OPTIONS
