#!/bin/bash
#SBATCH --job-name=ivae
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100Gb
#SBATCH --time=1-00:00:00

module load miniconda/3 pytorch/1.8.1
conda activate research
python main.py --config continuous-2-2-lbfgs.yaml --n-sims 1 --m 2.0 --s 0 --ckpt_folder='run/checkpoints/'
