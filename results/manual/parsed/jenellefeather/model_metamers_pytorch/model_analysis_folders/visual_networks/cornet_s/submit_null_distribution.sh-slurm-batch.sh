#!/bin/bash
#SBATCH --job-name=null_cnet
#SBATCH --output=output/null_cnet.out
#SBATCH --error=output/null_cnet.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=16000
#SBATCH --time=2-02:00:00
#SBATCH --constraint=high-capacity
#SBATCH --array=0-4

export CONDA_ENVS_PATH='~/my-envs:/om4/group/mcdermott/user/jfeather/conda_envs_files'

module add openmind/miniconda/2020-01-29-py3.7
module add openmind/cudnn/9.1-7.0.5
module add openmind/cuda/9.1
cp ../../../analysis_scripts/make_null_distributions.py .
export CONDA_ENVS_PATH=~/my-envs:/om4/group/mcdermott/user/jfeather/conda_envs_files
source activate /om4/group/mcdermott/user/jfeather/conda_envs_files/pytorch
python make_null_distributions.py -N 200000 -R $SLURM_ARRAY_TASK_ID
