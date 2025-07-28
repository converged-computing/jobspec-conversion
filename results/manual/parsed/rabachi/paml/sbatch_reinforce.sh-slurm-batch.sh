#!/bin/bash
#FLUX: --job-name=reinforce_paml_2_traj200
#FLUX: -c=2
#FLUX: --queue=cpu
#FLUX: --urgency=16

module load pytorch1.0-cuda9.0-python3.6
. /h/abachiro/mjpro200-py.env
ulimit -u 1000
echo Running reinforce experiments... reinforce_paml_states2_traj200
 python parser.py --algo reinforce --model_type paml --max_actions 200 --states_dim 2 --salient_states_dim 2 \
        --extra_dims_stable True --model_size small --initial_model_lr 1e-4 --real_episodes 5 --num_iters 400 \
        --virtual_episodes 500 --rs $SLURM_ARRAY_TASK_ID --save_checkpoints_training True \
        --file_id 'fid4_'$SLURM_ARRAY_TASK_ID
