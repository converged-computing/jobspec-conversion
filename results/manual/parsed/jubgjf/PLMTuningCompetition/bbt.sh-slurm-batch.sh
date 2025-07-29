#!/bin/bash
#SBATCH --job-name=bbt
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:nvidia_a100_80gb_pcie:1
#SBATCH --time=10:00:00
#SBATCH --partition=compute

source ~/.local/bin/miniconda3/etc/profile.d/conda.sh
conda activate bbt
python bbt.py --seed 8 --task_name 'sst2'
python bbt.py --seed 8 --task_name 'qnli'
python bbt.py --seed 8 --task_name 'qqp'
python bbt.py --seed 8 --task_name 'snli'
python bbt.py --seed 8 --task_name 'dbpedia'
