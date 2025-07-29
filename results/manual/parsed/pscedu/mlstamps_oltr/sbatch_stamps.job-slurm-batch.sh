#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=GPU-shared

set +x
cd  ${PROJECT}/${USER}/mlstamps_oltr/
conda activate mlstamps
CUDA_VISIBLE_DEVICES=0 python inference.py --config config/stamps/stage_2_meta_embedding.py --test_open
