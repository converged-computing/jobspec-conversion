#!/bin/bash
#SBATCH --job-name=score_radio_g01_3
#SBATCH --output=score_radio_g01_3%j.out
#SBATCH --error=score_radio_g01_3%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --constraint=ntasks-per-node=1

export PYTHONPATH='$PYTHONPATH:$WORK/GitHub/score'

module purge
module load tensorflow-gpu/py3/1.15.2
set -x
export PYTHONPATH="$PYTHONPATH:$WORK/GitHub/alpha-transform"
export PYTHONPATH="$PYTHONPATH:$WORK/GitHub/score"
cd $WORK/GitHub/ShapeDeconv/scripts/score/score_radio_g01
python ./score_radio_g01_3.py
