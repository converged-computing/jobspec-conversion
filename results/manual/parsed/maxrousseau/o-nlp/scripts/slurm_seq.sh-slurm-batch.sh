#!/bin/bash
#SBATCH --mail-user=maximerousseau08@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=16G
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=8

module purge
module load StdEnv/2020 gcc/9.3.0 arrow/11.0.0 python/3.10
source ~/projects/def-azouaq/mrouss/onlp-env/bin/activate
pip list
cd ~/projects/def-azouaq/mrouss/o-nlp/
wandb offline
nvidia-smi
python main.py configs/t5_sft.toml
