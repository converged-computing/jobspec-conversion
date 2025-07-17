#!/bin/bash
#FLUX: --job-name=phat-hobbit-4729
#FLUX: --queue=top6
#FLUX: -t=36000
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$CONDA_PREFIX/lib/:$CUDNN_PATH/lib:$LD_LIBRARY_PATH'
export PATH='${PATH}:/usr/local/nvidia/bin:/usr/local/cuda/bin'

CUDNN_PATH=$(dirname $(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)"))
export LD_LIBRARY_PATH=$CONDA_PREFIX/lib/:$CUDNN_PATH/lib:$LD_LIBRARY_PATH
export PATH="${PATH}:/usr/local/nvidia/bin:/usr/local/cuda/bin"
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
python3 main.py --config_name transfer_4
