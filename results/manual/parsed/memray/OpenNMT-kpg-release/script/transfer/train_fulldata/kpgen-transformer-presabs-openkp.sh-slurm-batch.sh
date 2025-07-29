#!/bin/bash
#SBATCH --job-name=train-TFpresabs-openkp
#SBATCH --account=hdaqing
#SBATCH --output=slurm_output/train-TFpresabs-openkp.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --time=6-00:00:00
#SBATCH --qos=long
#SBATCH --constraint=ntasks-per-node=1

export CONFIG_PATH='config/transfer_kp/train/transformer-presabs-openkp.yml'

export CONFIG_PATH="config/transfer_kp/train/transformer-presabs-openkp.yml"
cmd="python train.py -config $CONFIG_PATH"
echo $CONFIG_PATH
echo $cmd
$cmd
