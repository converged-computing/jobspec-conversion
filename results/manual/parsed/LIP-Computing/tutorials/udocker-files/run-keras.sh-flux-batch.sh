#!/bin/bash
#FLUX: --job-name=run_keras
#FLUX: --queue=gpu
#FLUX: --urgency=16

export TUT_DIR='$HOME/udocker-tutorial'
export PATH='$HOME/udocker-1.3.10/udocker:$PATH'
export UDOCKER_DIR='$TUT_DIR/.udocker'

export TUT_DIR=$HOME/udocker-tutorial
export PATH=$HOME/udocker-1.3.10/udocker:$PATH
export UDOCKER_DIR=$TUT_DIR/.udocker
module load python
cd $TUT_DIR
echo "###############################"
udocker run -v $TUT_DIR/udocker-files/tensorflow:/home/user -w /home/user tf_gpu python3 keras_2_small.py
