#!/bin/bash
#FLUX: --job-name=preds
#FLUX: -c=4
#FLUX: -t=7200
#FLUX: --priority=16

source activate tiny_torch
python torchlightning_predict.py -DT 2021-08-12-21-31 -t 2 -lat 32.62 -lon -83.27 -hs 255 -c C13 -f
