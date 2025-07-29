#!/bin/bash
#SBATCH --account=imi@gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00
#SBATCH --qos=qos_gpu-dev
#SBATCH --exclusive
#SBATCH --constraint=v100-32g

export MASTER_PORT='1234'
export MASTER_ADDRESS='$(echo $slurm_nodes | cut -d' ' -f1)'

export MASTER_PORT=1234
slurm_nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST)
echo $slurm_nodes
export MASTER_ADDRESS=$(echo $slurm_nodes | cut -d' ' -f1)
echo $MASTER_ADDRESS
module load pytorch-gpu/py3/1.8.0
srun ./script_train.sh $@
