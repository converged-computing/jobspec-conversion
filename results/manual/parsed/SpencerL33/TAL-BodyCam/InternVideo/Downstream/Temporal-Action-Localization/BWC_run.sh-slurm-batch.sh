#!/bin/bash
#FLUX: --job-name=BWC
#FLUX: -t=900
#FLUX: --urgency=16

module load  StdEnv/2020  cuda cudnn
module load gcc opencv
nvidia-smi
source  ../../../ENV/bin/activate
echo "Testing..."
python -u ./train_eval.py ./configs/BWC.yaml --output BWC_out 2>&1 | tee BWC_out.log
