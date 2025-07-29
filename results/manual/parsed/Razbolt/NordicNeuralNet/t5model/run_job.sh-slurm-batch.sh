#!/bin/bash
#SBATCH --job-name=nmt_fineT
#SBATCH --output=translate_finet_out.output
#SBATCH --error=translate_finet_err.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=90GB
#SBATCH --time=2-00:00:00
#SBATCH --partition=preemptgpu
#SBATCH --constraint=ntasks-per-node=1

export WANDB_API_KEY=''
export https_proxy='http://hpc-proxy00.city.ac.uk:3128'

source /opt/flight/etc/setup.sh
flight env activate gridware
module load libs/nvidia-cuda/11.2.0/bin
module load gnu
export WANDB_API_KEY=
echo $WANDB_API_KEY
python --version
wandb login $WANDB_API_KEY --relogin
export https_proxy=http://hpc-proxy00.city.ac.uk:3128
python3 finetunning-t5.py
