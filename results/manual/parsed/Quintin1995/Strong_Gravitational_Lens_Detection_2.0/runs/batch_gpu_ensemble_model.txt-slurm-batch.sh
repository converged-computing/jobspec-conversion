#!/bin/bash
#SBATCH --job-name=ensemble_test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=128000
#SBATCH --time=10:00:00

module load TensorFlow/2.1.0-fosscuda-2019b-Python-3.7.4
module load matplotlib/3.1.1-fosscuda-2019b-Python-3.7.4
module load scikit-image/0.16.2-fosscuda-2019b-Python-3.7.4
python3 create_input_dep_ensemble.py --ensemble_name multi_test2 --network simple_net n_chunks 200
