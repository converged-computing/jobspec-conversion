#!/bin/bash
#FLUX: --job-name=fat-house-5945
#FLUX: -c=8
#FLUX: --urgency=16

export WEIGHT_ONE='7'
export WEIGHT_TWO='2'
export WEIGHT_THR='1'
export BASE_MODEL='inresnet'
export EPOCH='50'
export TRAINING_BATCH_SIZE='64'
export TEST_BATCH_SIZE='8'
export IMG_HEIGHT='137'
export IMG_WIDTH='236'
export MODEL_MEAN='(.485,.456,.406)'
export MODEL_STD='(.229,.224,.225)'
export TRAINING_FOLDS_CSV='../input/train_fols.csv'
export TRAINING_FOLDS='1,2,3,4'
export VAL_FOLDS='(0,)'

module add cuda10.1/toolkit
module load shared
module load ml-pythondeps-py36-cuda10.1-gcc/3.0.0
module load pytorch-py36-cuda10.1-gcc/1.3.1
source venv/bin/activate
export WEIGHT_ONE=7
export WEIGHT_TWO=2
export WEIGHT_THR=1
export BASE_MODEL="inresnet"
export EPOCH=50
export TRAINING_BATCH_SIZE=64
export TEST_BATCH_SIZE=8
export IMG_HEIGHT=137
export IMG_WIDTH=236
export MODEL_MEAN="(.485,.456,.406)"
export MODEL_STD="(.229,.224,.225)"
export TRAINING_FOLDS_CSV="../input/train_fols.csv"
export TRAINING_FOLDS="0,1,2,3"
export VAL_FOLDS="(4,)"
python3.6 train_with_ingnite.py
export TRAINING_FOLDS="0,1,2,4"
export VAL_FOLDS="(3,)"
python3.6 train_with_ingnite.py
export TRAINING_FOLDS="0,1,3,4"
export VAL_FOLDS="(2,)"
python3.6 train_with_ingnite.py
export TRAINING_FOLDS="0,2,3,4"
export VAL_FOLDS="(1,)"
python3.6 train_with_ingnite.py
export TRAINING_FOLDS="1,2,3,4"
export VAL_FOLDS="(0,)"
python3.6 train_with_ingnite.py
