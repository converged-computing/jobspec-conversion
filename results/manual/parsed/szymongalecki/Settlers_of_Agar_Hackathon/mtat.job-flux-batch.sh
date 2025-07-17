#!/bin/bash
#FLUX: --job-name=pytorch-gpu-condaenv
#FLUX: -c=8
#FLUX: --queue=brown
#FLUX: -t=82800
#FLUX: --urgency=16

echo "Running on $(hostname):"
module load Anaconda3
conda create --name pytorchenv
source activate pytorchenv
python -c "import torch; print(torch.cuda.get_device_name(0))"
python3 model1.py
