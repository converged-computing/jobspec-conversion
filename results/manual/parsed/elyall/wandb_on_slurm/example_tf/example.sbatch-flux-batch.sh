#!/bin/bash
#FLUX: --job-name=strawberry-nalgas-9077
#FLUX: -N=2
#FLUX: -c=4
#FLUX: --queue=aws
#FLUX: -t=1800
#FLUX: --urgency=16

date;hostname;id;pwd
echo 'activating virtual environment'
source wandb-venv/bin/activate
which python
config_yaml='/nfs/code/wandb_on_slurm/examples/examples/keras/keras-cnn-fashion/sweep-bayes-hyperband.yaml'
echo 'template:' $config_yaml
train_file='/nfs/code/wandb_on_slurm/examples/examples/keras/keras-cnn-fashion/train.py'
echo 'train_file:' $train_file
project_name='wandb_slurm_tf'
echo 'project_name:' $project_name
echo 'running script'
python wandb_on_slurm.py $config_yaml $train_file $project_name
