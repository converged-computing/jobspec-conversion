#!/bin/bash
#SBATCH --job-name=DDDQN
#SBATCH --output=slurm_outputs/rljob_%j.out
#SBATCH --error=slurm_outputs/rljob_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=64G
#SBATCH --time=6-23:59:59
#SBATCH --constraint=A100

echo "Running python code on $(hostname) with algorithm $1"
python3 src/main.py --agent_config_path=configs/$1.yaml --env_config_path=configs/highway-env_config.json
