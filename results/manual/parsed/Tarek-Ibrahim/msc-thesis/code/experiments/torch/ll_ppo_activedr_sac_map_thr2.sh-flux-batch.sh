#!/bin/bash
#FLUX: --job-name=ppo_activedr_sac_map_thr_torch
#FLUX: -c=10
#FLUX: -t=259200
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/lib/nvidia'

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/nvidia
module load mesa/21.2.3-opengl-osmesa-python3-llvm
module load anaconda
module load mujoco/2.1.0
case $SLURM_ARRAY_TASK_ID in
   0)  SEED=101 ;;
   1)  SEED=102  ;;
   2)  SEED=103  ;;
esac
python main2.py --mode=1 --verbose=1 --dr_type=active_dr --agent_alg=ppo --env_key=lunarlander --active_dr_opt=sac --active_dr_rewarder=map_thr --seed=$SEED
