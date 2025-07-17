#!/bin/bash
#FLUX: --job-name=mfch
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load pytorch1.0-cuda9.0-python3.6
. /h/abachiro/mjpro200-py.env
ulimit -u 1000
python parser.py --algo ac --model_type model_free --env HalfCheetah-v2 --max_actions 1000 --states_dim 17 \
                  --salient_states_dim 17 --num_action_repeats 1 --verbose 5 --rs $SLURM_ARRAY_TASK_ID \
                  --file_id $SLURM_ARRAY_TASK_ID
echo Running ac experiments...
