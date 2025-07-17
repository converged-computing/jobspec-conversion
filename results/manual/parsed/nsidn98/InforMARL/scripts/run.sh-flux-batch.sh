#!/bin/bash
#FLUX: --job-name=salted-citrus-3347
#FLUX: -n=10
#FLUX: --urgency=16

source /etc/profile
module load anaconda/2021a
mkdir -p out_files
agents=(3 5 7 10)
obst=(3 5 7 10)
args_agents=()
args_obst=()
runs=()
count=1
for i in ${!agents[@]}; do
    for j in ${!obst[@]}; do
        args_agents+=(${agents[$i]})
        args_obst+=(${obst[$j]})
        runs+=($count)
        count=$(( $count + 1 ))
    done
done
python -m maddpg.main 'navigation' 'Navigation' \
--exp_name='simpleNavigation' \
--num_agents=${args_agents[$SLURM_ARRAY_TASK_ID]} \
--num_obstacles=${args_obst[$SLURM_ARRAY_TASK_ID]} \
--curr_run=${runs[$SLURM_ARRAY_TASK_ID]} \
&> out_files/out_${args_agents[$SLURM_ARRAY_TASK_ID]}__${args_obst[$SLURM_ARRAY_TASK_ID]}
