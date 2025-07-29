#!/bin/bash
#SBATCH --job-name=train-TF-one2one-kptimes
#SBATCH --account=hdaqing
#SBATCH --output=slurm_output/train-TF-one2one-kptimes.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --time=3-00:00:00
#SBATCH --partition=gtx1080
#SBATCH --qos=long
#SBATCH --constraint=ntasks-per-node=1

export CONFIG_PATH='config/transfer_kp/train/transformer-one2one-kptimes.yml'

export CONFIG_PATH="config/transfer_kp/train/transformer-one2one-kptimes.yml"
cmd="python train.py -config $CONFIG_PATH"
echo $CONFIG_PATH
echo $cmd
$cmd
