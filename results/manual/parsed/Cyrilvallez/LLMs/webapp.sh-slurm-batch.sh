#!/bin/bash
#SBATCH --job-name=webapp
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=30G
#SBATCH --time=10-00:00:00
#SBATCH --partition=nodes
#SBATCH --chdir=/cluster/raid/home/vacy/LLMs

eval "$(conda shell.bash hook)"
conda activate llm
../frp_server/frp_0.54.0_linux_amd64/frpc -c ../frp_server/frpc/frpc_play.toml &
python3 -u webapp.py "$@"
conda deactivate
