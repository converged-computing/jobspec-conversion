#!/bin/bash
#FLUX: --job-name=moska_no_cumulate
#FLUX: -c=64
#FLUX: --queue=gpusmall
#FLUX: -t=21600
#FLUX: --urgency=16

export CUDNN_PATH='$CUDNN_PATH'
export LD_LIBRARY_PATH='${CUDNN_PATH}/lib'

module purge
module load tensorflow/2.15
env
echo $LOCAL_SCRATCH
python3 -m venv $LOCAL_SCRATCH/.venv
source $LOCAL_SCRATCH/.venv/bin/activate
PIP_EXE=$LOCAL_SCRATCH/.venv/bin/pip3
$PIP_EXE install --extra-index-url https://pypi.nvidia.com tensorrt-bindings==8.6.1 tensorrt-libs==8.6.1 tensorflow[and-cuda]==2.15
$PIP_EXE install -e ./RLFramework
nvidia-smi
PYTHON_EXE=$LOCAL_SCRATCH/.venv/bin/python3
echo $CUDNN_PATH
echo $LD_LIBRARY_PATH
CUDNN_FILE=$($PYTHON_EXE -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)")
echo $CUDNN_FILE
CUDNN_PATH=$(dirname $CUDNN_FILE)
export CUDNN_PATH=$CUDNN_PATH
export LD_LIBRARY_PATH=${CUDNN_PATH}/lib
$PYTHON_EXE -c "import tensorflow as tf; print(tf.__version__)"
$PYTHON_EXE -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
$PYTHON_EXE --version
MODEL_FOLDER_PATH=/projappl/project_2010270/RLFramework/MoskaModelsNoCumulate/
$PYTHON_EXE ./Moska/fit_model.py --model_folder_base=$MODEL_FOLDER_PATH \
--starting_epoch=0 \
--num_epochs=20 \
--data_folder_base=$LOCAL_SCRATCH/MoskaDataNoCumulate/ \
--num_cpus=64 \
--num_games=10240 \
--num_files=512 \
--delete_data_after_fit
