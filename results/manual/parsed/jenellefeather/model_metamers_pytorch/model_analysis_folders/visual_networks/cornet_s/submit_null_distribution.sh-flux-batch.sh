#!/bin/bash
#FLUX: --job-name=null_cnet
#FLUX: -c=4
#FLUX: --queue=normal
#FLUX: -t=180000
#FLUX: --priority=16

export CONDA_ENVS_PATH='~/my-envs:/om4/group/mcdermott/user/jfeather/conda_envs_files'

module add openmind/miniconda/2020-01-29-py3.7
module add openmind/cudnn/9.1-7.0.5
module add openmind/cuda/9.1
cp ../../../analysis_scripts/make_null_distributions.py .
export CONDA_ENVS_PATH=~/my-envs:/om4/group/mcdermott/user/jfeather/conda_envs_files
source activate /om4/group/mcdermott/user/jfeather/conda_envs_files/pytorch
python make_null_distributions.py -N 200000 -R $SLURM_ARRAY_TASK_ID
