#!/bin/bash
#SBATCH --job-name=exp4_AE
#SBATCH --output=./exp4/pytorch_job_%j.out
#SBATCH --error=./exp4/pytorch_job_%j.err
#SBATCH --mail-user=mauricio.diaz-melo@inria.fr
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --mem=60G
#SBATCH --time=20:00:00
#SBATCH --partition=gpu_p1
#SBATCH --chdir=/gpfswork/rech/zft/upd53tc/jobs2/AD-DL/train/patch_level/autoencoder
#SBATCH --array=0-4

eval "$(conda shell.bash hook)"
conda activate clinicadl_env_py37
NETWORK="Conv4_FC3"
COHORT="ADNI"
DATE="reproducibility_results_2"
CAPS_DIR="$SCRATCH/../commun/datasets/${COHORT}_rerun"
TSV_PATH="$HOME/code/AD-DL/data/$COHORT/lists_by_diagnosis/train"
OUTPUT_DIR="$SCRATCH/results/$DATE/"
NUM_PROCESSORS=32
GPU=1
PREPROCESSING='linear'
DIAGNOSES="AD CN MCI"
HIPPOCAMPUS_ROI=1
SPLITS=5
SPLIT=$SLURM_ARRAY_TASK_ID
EPOCHS=100
BATCH=32
BASELINE=0
ACCUMULATION=1
EVALUATION=20
LR=1e-5
WEIGHT_DECAY=0
GREEDY_LEARNING=0
SIGMOID=0
NORMALIZATION=1
PATIENCE=50
T_BOOL=0
T_PATH=""
T_DIFF=0
OPTIONS=""
if [ $GPU = 1 ]; then
  OPTIONS="${OPTIONS} --use_gpu"
fi
if [ $NORMALIZATION = 1 ]; then
  OPTIONS="${OPTIONS} --minmaxnormalization"
fi
if [ $T_BOOL = 1 ]; then
  OPTIONS="$OPTIONS --pretrained_path $T_PATH -d $T_DIFF"
fi
if [ $BASELINE = 1 ]; then
  echo "using only baseline data"
  OPTIONS="$OPTIONS --baseline"
fi
if [ $HIPPOCAMPUS_ROI = 1 ]; then
  OPTIONS="$OPTIONS --hippocampus_roi"
fi
NAME="patch3D_model-${NETWORK}_preprocessing-${PREPROCESSING}_task-autoencoder_baseline-${BASELINE}_norm-${NORMALIZATION}_hippocampus"
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
  --train_autoencoder \
  --nproc $NUM_PROCESSORS \
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
  --visualization \
  $OPTIONS
