#!/bin/bash
#SBATCH --job-name=annotate
#SBATCH --account=eqb@a100
#SBATCH --output=out/annotate_%j.out
#SBATCH --error=out/annotate_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=04:00:00
#SBATCH --constraint=a100,ntasks-per-node=1

module purge
module load cpuarch/amd
module load python
conda activate childes_grammaticality
set -x
TRANSFORMERS_OFFLINE=1
model=lightning_logs/version_408635
data_dir=data/manual_annotation/all/
python -u grammaticality_annotation/annotate_grammaticality_nn.py --model $model --data-dir $data_dir
