#!/bin/bash
#FLUX: --job-name=stinky-poo-9969
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/home/gridsan/sidnayak/.mujoco/mujoco200/bin'

source /etc/profile
module load anaconda/2020a 
module load mpi/openmpi-4.0
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/gridsan/sidnayak/.mujoco/mujoco200/bin
envs=("FetchSlideFrictionControl" "FetchSlideImperfectControl" "FetchSlide" "FetchPushImperfect" "FetchPushSlippery" "FetchPush" "FetchPickAndPlacePerfect" "FetchPickAndPlaceSticky" "FetchPickAndPlace")
seeds=(0 1 2 3 4)
exp_names=("res" "res" "rl" "res" "res" "rl" "res" "res" "rl")
epochs=(500 500 500 200 200 200 500 500 500)
for i in ${!seeds[@]}; do
    # run for different seeds
    for j in ${!envs[@]}; do
        # run for all different envs
        echo "Env Name: ${envs[$j]} | Seed: ${seeds[$i]} | Exp Name: ${exp_names[$j]} | out_${envs[$j]}_${seeds[i]}"
        mpirun python -m RL.ddpg.ddpg_mpi --env_name ${envs[$j]} --seed ${seeds[$i]} --n_epochs ${epochs[$j]}  --exp_name ${exp_names[$j]} 2>&1 | tee exp_outputs/out_${envs[$j]}_${seeds[i]}
    done
done
