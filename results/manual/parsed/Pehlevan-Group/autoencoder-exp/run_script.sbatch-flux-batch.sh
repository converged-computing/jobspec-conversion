#!/bin/bash
#FLUX: --job-name=salted-toaster-6630
#FLUX: --urgency=16

source activate pytorch
python3 auto_encoder_gd.py --input_dim $inputDim --nb_fixed_point $nbFixedPoint --nb_layer $nbLayer --hidden_dim $hiddenDim --dir $Dir --act $Act
