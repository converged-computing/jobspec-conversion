#!/bin/bash
#SBATCH --job-name=ensembles
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=128000
#SBATCH --time=15:00:00
#SBATCH --partition=gpu
#SBATCH --array=1-10

module load TensorFlow/2.1.0-fosscuda-2019b-Python-3.7.4
module load matplotlib/3.1.1-fosscuda-2019b-Python-3.7.4
module load scikit-image/0.16.2-fosscuda-2019b-Python-3.7.4
python3 create_input_dep_ensemble.py --run=runs/ensemble_runs/run${SLURM_ARRAY_TASK_ID}.yaml
