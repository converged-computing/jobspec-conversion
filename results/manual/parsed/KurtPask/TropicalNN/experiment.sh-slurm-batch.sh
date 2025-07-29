#!/bin/bash
#SBATCH --job-name=tropical_nn
#SBATCH --output=batch_print_outputs/result-%j.out
#SBATCH --error=batch_print_outputs/error-%j.err
#SBATCH --mail-user=kurt.pasque@nps.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=25
#SBATCH --gres=gpu:8
#SBATCH --time=20:00:00
#SBATCH --partition=beards

. /etc/profile
module load lang/python/3.8.11
pip install -r $HOME/TropicalNN/requirements.txt
pip install tensorflow_datasets
pip install easydict
pip install cleverhans
python $HOME/TropicalNN/cleverhans_model_builds.py > $HOME/TropicalNN/batch_print_outputs/run.txt
