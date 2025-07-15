#!/bin/bash
#FLUX: --job-name=faux-knife-5216
#FLUX: --queue=LongJobs
#FLUX: -t=288000
#FLUX: --priority=16

export CUDA_HOME='/opt/cuda-9.0.176.1/'
export CUDNN_HOME='/opt/cuDNN-7.0/'
export STUDENT_ID='$(whoami)'
export LD_LIBRARY_PATH='${CUDNN_HOME}/lib64:${CUDA_HOME}/lib64:$LD_LIBRARY_PATH'
export LIBRARY_PATH='${CUDNN_HOME}/lib64:$LIBRARY_PATH'
export CPATH='${CUDNN_HOME}/include:$CPATH'
export PATH='${CUDA_HOME}/bin:${PATH}'
export PYTHON_PATH='$PATH'
export TMPDIR='/disk/scratch/${STUDENT_ID}/'
export TMP='/disk/scratch/${STUDENT_ID}/'
export DATASET_DIR='${TMP}data'

export CUDA_HOME=/opt/cuda-9.0.176.1/
export CUDNN_HOME=/opt/cuDNN-7.0/
export STUDENT_ID=$(whoami)
export LD_LIBRARY_PATH=${CUDNN_HOME}/lib64:${CUDA_HOME}/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=${CUDNN_HOME}/lib64:$LIBRARY_PATH
export CPATH=${CUDNN_HOME}/include:$CPATH
export PATH=${CUDA_HOME}/bin:${PATH}
export PYTHON_PATH=$PATH
mkdir -p /disk/scratch/${STUDENT_ID}
export TMPDIR=/disk/scratch/${STUDENT_ID}/
export TMP=/disk/scratch/${STUDENT_ID}/
echo "Copying dataset."
export DATASET_DIR=${TMP}data
mkdir -p $DATASET_DIR
rsync -ua /home/${STUDENT_ID}/image-colorization/data/places100 $DATASET_DIR
echo "DATASET_DIR: $DATASET_DIR"
source /home/${STUDENT_ID}/miniconda3/bin/activate mlp
echo "Starting training."
python /home/${STUDENT_ID}/image-colorization/train.py \
    --task=colorizer \
    --experiment-name=resnet_places100_long_300e \
    --model-name=resnet \
    --dataset-root-path=$DATASET_DIR \
    --dataset-name=places100 \
    --model-path=/home/${STUDENT_ID}/models/ \
    --train-batch-size=100 \
    --val-batch-size=100 \
    --batch-output-frequency=10 \
    --max-images=500 \
    --max-epochs=300
