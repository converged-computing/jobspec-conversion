#!/bin/bash
#FLUX: --job-name=resnet34
#FLUX: -c=8
#FLUX: -t=604800
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'
export IMG_HEIGHT='137'
export IMG_WIDTH='236'
export EPOCH='50'
export TRAINING_BATCH_SIZE='32'
export TEST_BATCH_SIZE='8'
export MODEL_MEAN='(.485,.456,.406)'
export MODEL_STD='(.229,.224,.225)'
export BASE_MODEL='resnet34'
export TRAINING_FOLDS_CSV='../input/train_fols.csv'
export TRAINING_FOLDS='0,1,2,4'
export VAL_FOLDS='(3,)'

module add cuda10.1/toolkit
module load shared
module load ml-pythondeps-py36-cuda10.1-gcc/3.0.0
module load pytorch-py36-cuda10.1-gcc/1.3.1
source venv/bin/activate
export CUDA_VISIBLE_DEVICES=0
export IMG_HEIGHT=137
export IMG_WIDTH=236
export EPOCH=50
export TRAINING_BATCH_SIZE=32
export TEST_BATCH_SIZE=8
export MODEL_MEAN="(.485,.456,.406)"
export MODEL_STD="(.229,.224,.225)"
export BASE_MODEL="resnet34"
export TRAINING_FOLDS_CSV="../input/train_fols.csv"
export TRAINING_FOLDS="0,1,2,3"
export VAL_FOLDS="(4,)"
python train.py
export TRAINING_FOLDS="0,1,2,4"
export VAL_FOLDS="(3,)"
python train.py
