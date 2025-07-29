#!/bin/bash
#SBATCH --job-name=zhilong
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1

module load cuda/11.3
python evaluate_guangcui.py --model_path /fs0/home/liqiang/onega_test/hydra/singlerun/2023-04-11/catalyst_oqmd/ --tasks opt --start_from no
