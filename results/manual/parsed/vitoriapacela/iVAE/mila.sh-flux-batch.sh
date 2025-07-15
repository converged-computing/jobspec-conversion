#!/bin/bash
#FLUX: --job-name=ivae
#FLUX: -t=86400
#FLUX: --priority=16

module load miniconda/3 pytorch/1.8.1
conda activate research
python main.py --config continuous-2-2-lbfgs.yaml --n-sims 1 --m 2.0 --s 0 --ckpt_folder='run/checkpoints/'
