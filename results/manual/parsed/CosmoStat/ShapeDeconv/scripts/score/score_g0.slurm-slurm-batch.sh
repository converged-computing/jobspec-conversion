#!/bin/bash
#SBATCH --job-name=tikho_train
#SBATCH --output=score_g0%j.out
#SBATCH --error=score_g0%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=14:00:00
#SBATCH --constraint=ntasks-per-node=1

export PYTHONPATH='$PYTHONPATH:$WORK/GitHub/score'

module purge
module load tensorflow-gpu/py3/1.15.2
set -x
export PYTHONPATH="$PYTHONPATH:$WORK/GitHub/alpha-transform"
export PYTHONPATH="$PYTHONPATH:$WORK/GitHub/score"
cd $WORK/GitHub/ShapeDeconv/scripts
python ./score_g0.py
