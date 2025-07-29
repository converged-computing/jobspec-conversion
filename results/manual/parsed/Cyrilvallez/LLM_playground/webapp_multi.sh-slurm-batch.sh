#!/bin/bash
#SBATCH --job-name=webapp
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=16G
#SBATCH --time=10-00:00:00
#SBATCH --partition=nodes
#SBATCH --chdir=/cluster/raid/home/vacy/LLM_playground

eval "$(conda shell.bash hook)"
conda activate llm-playground
../frp_server/frp_0.54.0_linux_amd64/frpc -c ../frp_server/frpc/frpc_play.toml &
python3 -u webapp_multi.py "$@"
conda deactivate
