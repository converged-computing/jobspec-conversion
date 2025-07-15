#!/bin/bash
#FLUX: --job-name=eccentric-rabbit-3671
#FLUX: --exclusive
#FLUX: --priority=16

i=1
for algo in "ppo-maskable"
do
	for map in "Sub20x20" #"Harvest40x40" "Sub40x40"
	do
		for ignition_type in "random" # "fixed"
		do
			for action_diameter in "1" #"2" #"xy"
			do
				for architecture in "CnnPolicy"
				do
				  for reward in "WillShenReward"
				  do
            for gamma in "0.9" #"0.5"
            do
              for seed in "1" "2" "3"
              do
                if [ $((i)) -eq  $((SLURM_ARRAY_TASK_ID + 0)) ]; then
                  python cell2fire/rl_experiment_vectorized.py --algo="$algo" --map="$map" --ignition_type="$ignition_type" --action_diameter="$action_diameter" --seed=$seed --architecture="$architecture" --gamma="$gamma" --num-processes=48 --reward="$reward" --tf_logdir=/home/gridsan/wshen/firehosetmp-sub20x20-willshenreward-final
                fi
                i=$((i+1))
              done
					  done
          done
				done
			done
		done
	done
done
echo $i
echo ${SLURM_ARRAY_TASK_ID}
