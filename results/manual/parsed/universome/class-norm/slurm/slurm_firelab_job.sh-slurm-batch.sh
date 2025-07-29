#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00

mkdir -p /tmp/skoroki/czsl/data
cp -r "/ibex/scratch/skoroki/datasets/${dataset}_feats" /tmp/skoroki/czsl/data
echo "`gpustat`"
echo "`nvidia-smi`"
echo "CLI args: $cli_args"
cd /home/skoroki/zslll-master
firelab start configs/zsl.yml $cli_args
