#!/bin/bash
#SBATCH --output=dyrep_trade_s5.txt
#SBATCH --error=dyrep_trade_s5error.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --mem=32G
#SBATCH --time=2-00:00:00
#SBATCH --partition=long

export HOME='/home/mila/h/huangshe'

export HOME="/home/mila/h/huangshe"
module load python/3.9
source $HOME/tgbenv/bin/activate
pwd
CUDA_VISIBLE_DEVICES=0 python examples/nodeproppred/un_trade/dyrep.py --seed 5
