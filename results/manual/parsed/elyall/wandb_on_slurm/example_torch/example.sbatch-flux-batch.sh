#!/bin/bash
#FLUX: --job-name=butterscotch-staircase-2964
#FLUX: -N=2
#FLUX: -c=4
#FLUX: --queue=aws
#FLUX: -t=1800
#FLUX: --urgency=16

date;hostname;id;pwd
echo 'activating virtual environment'
conda activate torch_example
which python
config_yaml='/nfs/code/wandb_on_slurm/example_torch/torch_params.yaml'
echo 'config:' $config_yaml
train_file='/nfs/code/wandb_on_slurm/example_torch/pytorch_model.py'
echo 'train_file:' $train_file
project_name='wandb_slurm_torch'
echo 'project_name:' $project_name
echo 'running script'
python wandb_on_slurm.py $config_yaml $train_file $project_name
