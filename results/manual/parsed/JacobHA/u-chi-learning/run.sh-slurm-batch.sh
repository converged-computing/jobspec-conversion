#!/bin/bash
#SBATCH --job-name=u-chi
#SBATCH --output=outfiles/%j.out
#SBATCH --error=outfiles/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:1
#SBATCH --mem=32gb
#SBATCH --time=2-23:00:00
#SBATCH --array=1-4

export CPATH='$CPATH:$CONDA_PREFIX/include'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$CONDA_PREFIX/lib'
export MUJOCO_GL='glfw'

echo "using scavenger"
eval "$(conda shell.bash hook)"
conda activate /home/jacob.adamczyk001/miniconda3/envs/oblenv
export CPATH=$CPATH:$CONDA_PREFIX/include
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib
export MUJOCO_GL="glfw"
echo "Start Run"
echo `date`
python experiments/local_finetuned_runs.py --env PongNoFrameskip-v4 -a u -d cuda
echo "Finish Run"
echo "end time is `date`"
