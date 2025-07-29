#!/bin/bash
#SBATCH --job-name=train-tf-DA-kptimes
#SBATCH --account=hdaqing
#SBATCH --output=slurm_output/train-tf-DA-kptimes.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16GB
#SBATCH --time=6-00:00:00
#SBATCH --qos=long
#SBATCH --constraint=ntasks-per-node=1

export CONFIG_PATH='script/transfer/train_tf_DA/transformer-DA-kptimes.yml'

export CONFIG_PATH="script/transfer/train_tf_DA/transformer-DA-kptimes.yml"
cmd="python train.py -config $CONFIG_PATH"
echo $CONFIG_PATH
echo $cmd
$cmd
