#!/bin/bash
#FLUX: --job-name=eccentric-leopard-8004
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/home/gridsan/sidnayak/.mujoco/mujoco200/bin'

source /etc/profile
module load anaconda/2020a 
module load mpi/openmpi-4.0
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/gridsan/sidnayak/.mujoco/mujoco200/bin
envs="NutAssemblyDense"
seeds=0
exp_names="rl"
mkdir ${exp_names}_${envs}
python -m RL.sac.sac --env_name ${envs} --seed ${seeds} --exp_name ${exp_names} 2>&1 | tee ${exp_names}_${envs}/out_${envs}_${seeds}
