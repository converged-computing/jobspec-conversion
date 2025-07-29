#!/bin/bash
#SBATCH --job-name=experiment_app
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:5
#SBATCH --mem=50G
#SBATCH --time=10-00:00:00
#SBATCH --partition=nodes
#SBATCH --chdir=/cluster/raid/home/vacy/LLMs

eval "$(conda shell.bash hook)"
conda activate llm
../frp_server/frp_0.54.0_linux_amd64/frpc -c ../frp_server/frpc/frpc_experiment.toml &
python3 -u experiment_webapp.py
conda deactivate
