#!/bin/bash
#SBATCH --job-name=joint_12
#SBATCH --account=cla173
#SBATCH --output=exp_texture_joint_12.%j.%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:k80:1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=6

export CPATH='/home/enijkamp/cudnn-3.0/include/'
export LD_LIBRARY_PATH='/home/enijkamp/cudnn-3.0/lib64:$LD_LIBRARY_PATH'
export LIBRARY_PATH='/home/enijkamp/cudnn-3.0/lib64:$LIBRARY_PATH'

export CPATH=/home/enijkamp/cudnn-3.0/include/
export LD_LIBRARY_PATH=/home/enijkamp/cudnn-3.0/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=/home/enijkamp/cudnn-3.0/lib64:$LIBRARY_PATH
module load matlab
matlab -nodisplay -nosplash -nojvm -r "exp_texture_joint_12()"
