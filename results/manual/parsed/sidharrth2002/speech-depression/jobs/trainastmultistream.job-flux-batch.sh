#!/bin/bash
#FLUX: --job-name=astmultistream
#FLUX: -n=2
#FLUX: --queue=gpu.medium
#FLUX: -t=144000
#FLUX: --priority=16

module load python
pip install transformers datasets evaluate librosa torchmetrics opensmile scikit-learn nlpaug
python /home/snag0027/speech-depression/cluster/train_1d_conv.py
