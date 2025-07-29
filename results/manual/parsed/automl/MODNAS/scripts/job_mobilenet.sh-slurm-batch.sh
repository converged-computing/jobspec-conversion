#!/bin/bash
#SBATCH --output=logs/%j.%x.%N.out
#SBATCH --error=logs/%j.%x.%N.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:8
#SBATCH --time=5-00:00:00
#SBATCH --partition=<partition

export PYTHONPATH='.'

export PYTHONPATH=.
python -m torch.distributed.launch --nproc_per_node=8 --use_env search_spaces/MobileNetV3/search/mobilenet_search_base.py --one_shot_opt reinmax --opt_strategy "simultaneous" --hpn_type meta --use_pretrained_hpn 
