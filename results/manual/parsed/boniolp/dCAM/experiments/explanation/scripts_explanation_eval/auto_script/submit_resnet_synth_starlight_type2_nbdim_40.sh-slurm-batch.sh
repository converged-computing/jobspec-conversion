#!/bin/bash
#SBATCH --job-name=synth_explanation_resnet_synth_starlight_type2_nbdim_40
#SBATCH --output=auto_script/output_log/synth_explanation_resnet_synth_starlight_type2_nbdim_40.out
#SBATCH --error=auto_script/output_log/synth_explanation_resnet_synth_starlight_type2_nbdim_40.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00

module purge
module load pytorch-gpu/py3/1.7.0
set -x
python -u script_exp_dataset.py resnet baseline ../../../data/synthetic/synth_starlight_type2_nbdim_40.pickle 0.8
