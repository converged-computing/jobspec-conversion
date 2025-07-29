#!/bin/bash
#SBATCH --job-name=X-TMR
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --gres=gpu:hgx:4
#SBATCH --mem=300GB
#SBATCH --qos=preemptive

source activate temos
python -m train --cfg configs/configs_temos/H3D-TMR.yaml --cfg_assets configs/assets.yaml --nodebug
