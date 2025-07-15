#!/bin/bash
#FLUX: --job-name=exp14_cnn
#FLUX: -c=10
#FLUX: --queue=gpu_p1
#FLUX: -t=72000
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate clinicadl_env_py37
NETWORK="Conv4_FC3"
NETWORK_TYPE="multi"
COHORT="ADNI"
DATE="reproducibility_results_2"
NUM_CNN=36
USE_EXTRACTED_PATCHES=1
CAPS_DIR="$SCRATCH/../commun/datasets/${COHORT}_rerun"
TSV_PATH="$HOME/code/AD-DL/data/$COHORT/lists_by_diagnosis/train"
OUTPUT_DIR="$SCRATCH/results/$DATE/"
NUM_PROCESSORS=32
GPU=1
PREPROCESSING='linear'
DIAGNOSES="AD CN"
SPLITS=5
SPLIT=$SLURM_ARRAY_TASK_ID
EPOCHS=200
BATCH=32
BASELINE=1
ACCUMULATION=1
EVALUATION=20
LR=1e-5
WEIGHT_DECAY=1e-4
GREEDY_LEARNING=0
SIGMOID=0
NORMALIZATION=1
PATIENCE=15
T_BOOL=1
T_PATH="patch3D_model-Conv4_FC3_preprocessing-linear_task-autoencoder_baseline-1_norm-1_splits-5"
T_PATH="$SCRATCH/results/$DATE/$T_PATH"
T_DIFF=0
OPTIONS=""
if [ $GPU = 1 ]; then
  OPTIONS="${OPTIONS} --use_gpu"
fi
if [ $NORMALIZATION = 1 ]; then
  OPTIONS="${OPTIONS} --minmaxnormalization"
fi
if [ $T_BOOL = 1 ]; then
  OPTIONS="$OPTIONS --transfer_learning_autoencoder --transfer_learning_path $T_PATH"
fi
if [ $BASELINE = 1 ]; then
  echo "using only baseline data"
  OPTIONS="$OPTIONS --baseline"
fi
if [ $USE_EXTRACTED_PATCHES = 1 ]; then
  echo "Using extracted slices/patches"
  OPTIONS="$OPTIONS --use_extracted_patches"
fi
NAME="patch3D_model-${NETWORK}_preprocessing-${PREPROCESSING}_task-autoencoder_baseline-${BASELINE}_norm-${NORMALIZATION}_${NETWORK_TYPE}-cnn"
if [ $SPLITS > 0 ]; then
echo "Use of $SPLITS-fold cross validation, split $SPLIT"
NAME="${NAME}_splits-${SPLITS}"
fi
echo $NAME
clinicadl train \
  patch \
  $CAPS_DIR \
  $TSV_PATH \
  $OUTPUT_DIR$NAME \
  $NETWORK \
  --network_type $NETWORK_TYPE \
  --num_cnn $NUM_CNN \
  --batch_size $BATCH \
  --evaluation_steps $EVALUATION \
  --preprocessing $PREPROCESSING \
  --diagnoses $DIAGNOSES \
  --n_splits $SPLITS \
  --split $SPLIT \
  --accumulation_steps $ACCUMULATION \
  --epochs $EPOCHS \
  --learning_rate $LR \
  --weight_decay $WEIGHT_DECAY \
  --patience $PATIENCE \
  --selection_threshold 0.7 \
  $OPTIONS
