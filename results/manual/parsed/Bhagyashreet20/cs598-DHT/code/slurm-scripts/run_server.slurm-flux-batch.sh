#!/bin/bash
#FLUX: --job-name=start_x_server
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpuA100x4
#FLUX: -t=86400
#FLUX: --priority=16

export ET_DATA='/projects/bcng/ukakarla/teach_data'
export TEACH_ROOT_DIR='/projects/bcng/ukakarla/teach'
export ET_LOGS='/projects/bcng/ukakarla/teach_data/et_pretrained_models'
export TEACH_SRC_DIR='$TEACH_ROOT_DIR/src'
export ET_ROOT='$TEACH_SRC_DIR/teach/modeling/ET'
export INFERENCE_OUTPUT_PATH='/projects/bcng/ukakarla/teach/inference_output'
export PYTHONPATH='$TEACH_SRC_DIR:$ET_ROOT:$PYTHONPATH'
export DISPLAY=':1'

module load gcc python/3.8.18
module load anaconda3_gpu
module load cuda
module list
conda activate teachllms
conda install -y pytorch==1.13.0 torchvision==0.14.0 torchaudio==0.13.0 pytorch-cuda=11.6 -c pytorch -c nvidia
pip install -r /projects/bcng/ukakarla/teach/requirements.txt
export ET_DATA='/projects/bcng/ukakarla/teach_data'
export TEACH_ROOT_DIR='/projects/bcng/ukakarla/teach'
export ET_LOGS='/projects/bcng/ukakarla/teach_data/et_pretrained_models'
export TEACH_SRC_DIR="$TEACH_ROOT_DIR/src"
export ET_ROOT="$TEACH_SRC_DIR/teach/modeling/ET"
export INFERENCE_OUTPUT_PATH='/projects/bcng/ukakarla/teach/inference_output'
export PYTHONPATH="$TEACH_SRC_DIR:$ET_ROOT:$PYTHONPATH"
echo "Environment variables set:"
echo "PYTHONPATH=$PYTHONPATH"
echo "ET_DATA=$ET_DATA"
echo "ET_LOGS=$ET_LOGS"
echo "TEACH_ROOT_DIR=$TEACH_ROOT_DIR"
echo "TEACH_SRC_DIR=$TEACH_SRC_DIR"
echo "ET_ROOT=$ET_ROOT"
Xvfb :1 -screen 0 1024x768x24 &
export DISPLAY=:1
echo "Xvfb started on display ${DISPLAY}"
sleep 5  # Give some time for Xvfb to start
echo "Starting remote server"
srun --x11=first,local python /projects/bcng/ukakarla/teach/bin/startx.py
