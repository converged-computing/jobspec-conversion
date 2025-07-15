#!/bin/bash
#FLUX: --job-name=train_multihot_model
#FLUX: --queue=gpu-short
#FLUX: -t=120
#FLUX: --urgency=16

export CWD='$(pwd)'
export PATH_TO_PYFILE='$CWD'
export SCRIPTNAME='build_multi_hot_model.py'
export PYFILE='$CWD/$SCRIPTNAME'
export RUNDIR='$SCRATCH'
export IMAGE_DIR='$RUNDIR/images'
export MODEL_NAME='multihotmodel_$SLURM_JOB_ID'
export CSV_FILE='annotations.csv'

module load Python/3.7.4-GCCcore-8.3.0
module load SciPy-bundle/2019.10-fosscuda-2019b-Python-3.7.4
module load matplotlib/3.1.1-foss-2019b-Python-3.7.4
module load TensorFlow/2.2.0-fosscuda-2019b-Python-3.7.4
echo "[$SHELL] #### Starting GPU training job"
export CWD=$(pwd)
echo "[$SHELL] CWD: "$CWD
echo "[$SHELL] Using GPU: "$CUDA_VISIBLE_DEVICES
export PATH_TO_PYFILE=$CWD
echo "[$SHELL] Path of python file: "$PATH_TO_PYFILE
export SCRIPTNAME=build_multi_hot_model.py
export PYFILE=$CWD/$SCRIPTNAME
echo "[$SHELL] Node scratch: "$SCRATCH
export RUNDIR=$SCRATCH
export IMAGE_DIR=$RUNDIR/images
export MODEL_NAME=multihotmodel_$SLURM_JOB_ID
export CSV_FILE=annotations.csv
mkdir -p $IMAGE_DIR
cp images.tar $IMAGE_DIR/
tar -xf $IMAGE_DIR/images.tar
cp $PYFILE $RUNDIR/
cd $RUNDIR
echo "[$SHELL] Run script"
python3 $SCRIPTNAME $IMAGE_DIR $CSV_FILE $MODEL_NAME
echo "[$SHELL] Script finished"
echo "[$SHELL] Copy files back to cwd"
cp -r $MODEL_NAME $CWD/
echo "[$SHELL] #### Finished training."
