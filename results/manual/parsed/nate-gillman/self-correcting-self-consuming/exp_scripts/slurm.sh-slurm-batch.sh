#!/bin/bash
#SBATCH --output=exp_outputs/slurm_logs/%j.out
#SBATCH --error=exp_outputs/slurm_logs/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=63G
#SBATCH --time=4-00:00:00
#SBATCH --partition=3090-gcondo
#SBATCH --constraint=a6000|geforce3090
#SBATCH --exclude=gpu2108,gpu2114,gpu2115,gpu2116

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/lib/nvidia'

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/users/$USER/.mujoco/mujoco210/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/nvidia
module load mesa
module load boost/1.80.0
module load patchelf
module load glew
module load cuda
module load ffmpeg
source /gpfs/runtime/opt/anaconda/2020.02/etc/profile.d/conda.sh
conda activate /gpfs/home/ngillman/.conda/envs/scsc
HOME_DIR=/oscar/data/superlab/users/nates_stuff/self-correcting-self-consuming
cd ${HOME_DIR}
