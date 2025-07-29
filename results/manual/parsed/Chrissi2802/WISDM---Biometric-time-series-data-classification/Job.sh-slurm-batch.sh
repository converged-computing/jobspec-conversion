#!/bin/bash
#SBATCH --job-name=WISDM
#SBATCH --output=WISDM_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=64gb
#SBATCH --time=01:00:00
#SBATCH --nodelist=fang-s009

pwd; hostname; date
echo "Running Job"
source /home/student17/venv/bin/activate
python3 train_tf.py
deactivate
echo
date
