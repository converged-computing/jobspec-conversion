#!/bin/bash
#FLUX: --job-name=faux-lettuce-3787
#FLUX: -n=4
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

module load env/staging/2022.1
module load Python/3.10.4-GCCcore-11.3.0
ml SciPy-bundle/2022.05-foss-2022a 
ml PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
ml IPython/8.5.0-GCCcore-11.3.0
cd hpmlt
python __hpmlt__.py
