#!/bin/bash
#SBATCH --job-name=angorapy
#SBATCH --account=ich020
#SBATCH --nodes=32
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=normal
#SBATCH --constraint=ntasks-per-node=12,gpu&startx

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export CRAY_CUDA_MPS='1'
export DISPLAY=':0'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export CRAY_CUDA_MPS=1
module load daint-gpu
module load cudatoolkit
module use /apps/daint/UES/6.0.UP04/sandboxes/sarafael/modules/all
module load cuDNN/8.0.3.33
source ${HOME}/robovenv/bin/activate
export DISPLAY=:0
if test -z "$SCRIPTCOMMAND"
then
  srun python3 -u train.py HumanoidManipulateBlockDiscreteAsynchronous-v0 --pcon manipulate_discrete --rcon manipulate.penalized_force --model lstm --architecture shadow --save-every 300
else
  eval $SCRIPTCOMMAND
fi
