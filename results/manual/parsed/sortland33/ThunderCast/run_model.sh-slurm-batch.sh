#!/bin/bash
#SBATCH --job-name=ThunderCast
#SBATCH --output=/home/%u/output/sb_%j.log
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:2
#SBATCH --time=23:50:00
#SBATCH --partition=salvador
#SBATCH --constraint=ntasks-per-node=2

nvidia-smi
hostname
squeue -q `hostname -s`
echo $CUDA_VISIBLE_DEVICES
echo "----"
group=$(dcgmi group -c allgpus --default)
if [ $? -eq 0 ]; then
groupid=$(echo $group | awk '{print $10}')
dcgmi stats -g $groupid -e
dcgmi stats -g $groupid -s $SLURM_JOB_ID
fi
CONTAINER=/home/shared/containers/pytorch_22.04-py3.sif
source /etc/profile
srun singularity run -B /ships19 -B /apollo -B $HOME/local-pytorch:$HOME/.local --nv $CONTAINER python torchlightning_main.py
