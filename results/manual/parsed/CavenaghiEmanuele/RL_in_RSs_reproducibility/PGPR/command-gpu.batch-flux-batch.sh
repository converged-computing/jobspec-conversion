#!/bin/bash
#FLUX: --job-name=PGPR
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load cuda-11.2.1
module load anaconda3
nvidia-smi
conda activate rs_survey
python preprocess.py --dataset cd
python train_transe_model.py --dataset cd
python train_agent.py --dataset cd
python test_agent.py --dataset cd --run_path True --run_eval True
