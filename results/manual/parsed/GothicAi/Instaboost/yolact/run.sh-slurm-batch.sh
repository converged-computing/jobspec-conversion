#!/bin/bash
#SBATCH --job-name=yolact
#SBATCH --output=log.%j.out
#SBATCH --error=log.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=10:00:00

module load python/3.7.1
module load cuda/10.0
module load cudnn/7.4.2
source ~/ib/bin/activate
python train.py --config=yolact_base_config
