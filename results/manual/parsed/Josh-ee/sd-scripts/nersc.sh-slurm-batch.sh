#!/bin/bash
#SBATCH --job-name=sd-script
#SBATCH --account=m4633
#SBATCH --mail-user=gaoyang29@berkeley.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=23:59:00
#SBATCH --constraint=gpu

module load pytorch
source /pscratch/sd/y/yanggao/sd-scripts/venv/bin/activate
module load pytorch
python run.py
