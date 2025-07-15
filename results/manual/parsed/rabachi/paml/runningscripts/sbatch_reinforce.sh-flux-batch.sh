#!/bin/bash
#FLUX: --job-name=test_romina
#FLUX: -c=2
#FLUX: --priority=16

module load pytorch1.0-cuda9.0-python3.6
. /h/abachiro/mjpro200-py.env
ulimit -u 1000
echo Running reinforce experiments... reinforce_paml_states10_traj200 12-21
python parser.py --algo reinforce --model_type paml --max_actions 200 --states_dim 10 --salient_states_dim 2 --extra_dims_stable True --model_size small --initial_model_lr 1e-7 --real_episodes 5 --num_iters 200 --virtual_episodes 1000 --rs $SLURM_ARRAY_TASK_ID --save_checkpoints_training False --file_id 'final_smallModel_'$SLURM_ARRAY_TASK_ID
