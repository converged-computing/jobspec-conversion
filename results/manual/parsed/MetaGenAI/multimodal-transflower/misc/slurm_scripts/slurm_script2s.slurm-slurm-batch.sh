#!/bin/bash
#SBATCH --account=imi@gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:2
#SBATCH --time=20:00:00
#SBATCH --qos=qos_gpu-t3
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=2

export MASTER_PORT='1234'
export MASTER_ADDRESS='$(echo $slurm_nodes | cut -d' ' -f1)'

export MASTER_PORT=1234
slurm_nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST)
echo $slurm_nodes
export MASTER_ADDRESS=$(echo $slurm_nodes | cut -d' ' -f1)
echo $MASTER_ADDRESS
module load pytorch-gpu/py3/1.8.0
srun ./script_train.sh $@
