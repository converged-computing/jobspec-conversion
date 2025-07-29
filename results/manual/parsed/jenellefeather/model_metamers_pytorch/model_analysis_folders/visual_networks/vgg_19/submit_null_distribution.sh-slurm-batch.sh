#!/bin/bash
#SBATCH --job-name=null_vgg
#SBATCH --output=output/null_%A_%a.out
#SBATCH --error=output/null_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:GEFORCEGTX1080TI:1
#SBATCH --mem=128000
#SBATCH --time=6-06:00:00
#SBATCH --partition=normal
#SBATCH --constraint=high-capacity
#SBATCH --array=0

export CONDA_ENVS_PATH='~/my-envs:/om4/group/mcdermott/user/jfeather/conda_envs_files'

module add openmind/miniconda/2020-01-29-py3.7
module add openmind/cudnn/9.1-7.0.5
module add openmind/cuda/9.1
cp ../../../analysis_scripts/make_null_distributions.py .
export CONDA_ENVS_PATH=~/my-envs:/om4/group/mcdermott/user/jfeather/conda_envs_files
source activate /om4/group/mcdermott/user/jfeather/conda_envs_files/pytorch
python make_null_distributions.py -N 50000 -R 0 & 
python make_null_distributions.py -N 50000 -R 1 &
python make_null_distributions.py -N 50000 -R 2 &
python make_null_distributions.py -N 50000 -R 3 &
python make_null_distributions.py -N 50000 -R 4 &
python make_null_distributions.py -N 50000 -R 5 &
python make_null_distributions.py -N 50000 -R 6 &
python make_null_distributions.py -N 50000 -R 7 &
python make_null_distributions.py -N 50000 -R 8 &
python make_null_distributions.py -N 50000 -R 9 &
python make_null_distributions.py -N 50000 -R 10 &
python make_null_distributions.py -N 50000 -R 11 &
python make_null_distributions.py -N 50000 -R 12 &
python make_null_distributions.py -N 50000 -R 13 &
python make_null_distributions.py -N 50000 -R 14 &
python make_null_distributions.py -N 50000 -R 15 &
python make_null_distributions.py -N 50000 -R 16 &
python make_null_distributions.py -N 50000 -R 17 &
python make_null_distributions.py -N 50000 -R 18 &
python make_null_distributions.py -N 50000 -R 19 &
wait
