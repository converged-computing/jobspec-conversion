#!/bin/bash
#SBATCH --job-name=DINO_COCO
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:2
#SBATCH --time=5-00:00:00
#SBATCH --partition=bme_gpu
#SBATCH --constraint=ntasks-per-node=2

set -x
CONFIG=$1
PY_ARGS=${@:2}
source activate det
nvidia-smi
PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
python -u tools/train.py ${CONFIG} --launcher="slurm" ${PY_ARGS}
