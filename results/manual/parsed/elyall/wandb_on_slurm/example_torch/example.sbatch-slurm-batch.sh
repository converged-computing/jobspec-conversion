#!/bin/bash
#SBATCH --output=/nfs/logs/slurm-%j.log
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=00:30:00
#SBATCH --partition=aws
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=/nfs/code/wandb_on_slurm/

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
