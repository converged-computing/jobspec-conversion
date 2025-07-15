#!/bin/bash
#FLUX: --job-name=astute-egg-5704
#FLUX: -c=4
#FLUX: --priority=16

export PATH='$/homedtic/mnieto/project/anaconda3/envs/torch_thesis:$PATH'
export WANDB_API_KEY=''

module load CUDA/11.0.3
export PATH="$HOME/project/anaconda3/bin:$PATH"
export PATH="$/homedtic/mnieto/project/anaconda3/envs/torch_thesis:$PATH"
source activate torch_thesis
cd /homedtic/mnieto/project/TransformerGrooveTap2Drum/model/
export WANDB_API_KEY=""
python -m wandb login
wandb agent marinaniet0/test_sweep_t2d/qyp15cdc
