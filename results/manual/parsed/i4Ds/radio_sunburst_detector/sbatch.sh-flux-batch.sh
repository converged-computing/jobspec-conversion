#!/bin/bash
#FLUX: --job-name=conspicuous-fork-3521
#FLUX: --queue=top6
#FLUX: -t=36000
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$CONDA_PREFIX/lib/:$CUDNN_PATH/lib:$LD_LIBRARY_PATH'
export PATH='${PATH}:/usr/local/nvidia/bin:/usr/local/cuda/bin'

CUDNN_PATH=$(dirname $(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)"))
export LD_LIBRARY_PATH=$CONDA_PREFIX/lib/:$CUDNN_PATH/lib:$LD_LIBRARY_PATH
export PATH="${PATH}:/usr/local/nvidia/bin:/usr/local/cuda/bin"
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
wandb agent i4ds_radio_sunburst_detection/radio_sunburst_detection/pg4rf2ys
