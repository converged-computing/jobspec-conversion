#!/bin/bash
#FLUX: --job-name=LSTM_A100_DATA
#FLUX: --queue=toreador
#FLUX: --urgency=16

module load gcc cuda cudnn
. $HOME/conda/etc/profile.d/conda.sh
conda activate tensorflow
./clean # remove any results from prior runs and create a results folder
./launch
