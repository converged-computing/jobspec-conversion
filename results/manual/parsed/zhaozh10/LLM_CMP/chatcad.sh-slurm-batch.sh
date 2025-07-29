#!/bin/bash
#SBATCH --job-name=LLM_CMP_${TIME_SUFFIX}
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=10:00:00
#SBATCH --partition=bme_gpu4
#SBATCH --constraint=ntasks-per-node=1

nvidia-smi
set -x
TGT_dir=$1
TIME_SUFFIX=$(date +%Y%m%d%H%M%S)
source activate win
PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
python chatcad_eval.py --tgt_dir ${TGT_dir}
