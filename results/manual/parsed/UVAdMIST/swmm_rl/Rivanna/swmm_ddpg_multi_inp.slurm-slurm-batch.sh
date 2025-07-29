#!/bin/bash
#SBATCH --account=uvahydroinformatics
#SBATCH --output=swmm_ddpg_multi_inp.out
#SBATCH --error=swmm_ddpg_multi_inp.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --time=2-23:55:00

export SINGULARITYENV_MPLBACKEND='agg'

module purge
module load singularity tensorflow/1.12.0-py36
export SINGULARITYENV_MPLBACKEND="agg"
singularity-gpu exec /home/$USER/tensorflow-1.12.0-py36.simg python /home/$USER/swmm_rl/swmm_ddpg_multi_inp.py
