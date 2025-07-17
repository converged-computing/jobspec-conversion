#!/bin/bash
#FLUX: --job-name=rf-ulm_train
#FLUX: -c=4
#FLUX: --queue=gpu-invest
#FLUX: -t=64800
#FLUX: --urgency=16

module load Python/3.9.5-GCCcore-10.3.0
module load CUDA/11.8.0
source ~/20_rf-ulm/venv/bin/activate
python3 -c "import torch; print(torch.cuda.is_available())"
param_store=~/20_rf-ulm/bash_scripts/array_pala_params_8x.txt
model=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $1}')
model_file=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $2}')
threshold=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $3}')
type=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $4}')
python3 ./train.py model=${model} model_file=${model_file} nms_threshold=${threshold} input_type=${type} data_dir=/storage/workspaces/artorg_aimi/ws_00000/chris/PALA_data_InSilicoFlow/ logging=pala_train
