#!/bin/bash
#FLUX: --job-name=behavior_plot
#FLUX: -c=20
#FLUX: --queue=mcdermott
#FLUX: -t=36000
#FLUX: --priority=16

export CONDA_ENVS_PATH='~/my-envs:/om4/group/mcdermott/user/jfeather/conda_envs_files'

module add openmind/miniconda/2020-01-29-py3.7
module add openmind/cudnn/9.1-7.0.n5
module add openmind/cuda/9.1
export CONDA_ENVS_PATH=~/my-envs:/om4/group/mcdermott/user/jfeather/conda_envs_files
source activate /om4/group/mcdermott/user/jfeather/conda_envs_files/pytorch
cp ../../../plotting_and_analysis_scripts/make_esc_model_plots.py .
python make_esc_model_plots.py -D /nobackup/scratch/Fri/jfeather -L -2 -A 4096 -R 5 -P -O -C 0.01 0.1 1 10 100
