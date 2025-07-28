#!/bin/bash
#FLUX: --job-name=usman_clvrai
#FLUX: --urgency=16

seed=1
python3 -m rl.main --seed $seed --env two-jaco-pick-push-place-v0 --record 1 --gpu 0 --num_record_samples 1 --prefix ours --meta hard --subdiv left_arm,left_hand,cube1-left_arm/right_arm,right_hand,cube2-right_arm --subdiv_skills rl.two-jaco-push-v0.left-d.$seed/rl.two-jaco-pick-v0.right-d.$seed,rl.two-jaco-place-v0.right-center-d.$seed --max_meta_len 1
