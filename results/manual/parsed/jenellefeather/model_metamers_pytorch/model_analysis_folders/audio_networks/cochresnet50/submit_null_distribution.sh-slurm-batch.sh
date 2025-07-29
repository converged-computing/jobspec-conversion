#!/bin/bash
#FLUX: --job-name=null_alexnet
#FLUX: -c=20
#FLUX: --queue=mcdermott
#FLUX: -t=540000
#FLUX: --urgency=16

export CONDA_ENVS_PATH='~/my-envs:/om4/group/mcdermott/user/jfeather/conda_envs_files'

module add openmind/miniconda/2020-01-29-py3.7
module add openmind/cudnn/9.1-7.0.5
module add openmind/cuda/9.1
cp ../../../analysis_scripts/make_null_distributions.py .
export CONDA_ENVS_PATH=~/my-envs:/om4/group/mcdermott/user/jfeather/conda_envs_files
source activate /om4/group/mcdermott/user/jfeather/conda_envs_files/pytorch
python make_null_distributions.py -N 200000 -I 0 -R 0 --no-shuffle &
python make_null_distributions.py -N 200000 -I 1 -R 0 --no-shuffle &
python make_null_distributions.py -N 200000 -I 2 -R 0 --no-shuffle &
python make_null_distributions.py -N 200000 -I 3 -R 0 --no-shuffle &
python make_null_distributions.py -N 200000 -I 4 -R 0 --no-shuffle &
wait
