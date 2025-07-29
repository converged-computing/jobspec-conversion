#!/bin/bash
#SBATCH --job-name=u-chi
#SBATCH --output=outfiles/%j.out
#SBATCH --error=outfiles/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --mem=12gb
#SBATCH --time=2-23:00:00
#SBATCH --partition=Intel
#SBATCH --array=1-10

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
python experiments/experiment.py --do_sweep --env Acrobot-v1 --count 500
echo "Finish Run"
echo "end time is `date`"
