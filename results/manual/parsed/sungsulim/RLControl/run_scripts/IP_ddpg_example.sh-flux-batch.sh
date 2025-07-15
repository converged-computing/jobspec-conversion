#!/bin/bash
#FLUX: --job-name=IP_ddpg
#FLUX: -t=3600
#FLUX: --urgency=16

ENV_NAME=InvertedPendulum-v2
AGENT_NAME=ddpg
module load singularity/2.5
echo Running..$ENV_NAME $AGENT_NAME $SLURM_ARRAY_TASK_ID
singularity exec -B /scratch /home/sungsu/rl-docker-private-tf1.8.0-gym0.10.3-py35.simg python3 ../main.py --env_json ../jsonfiles/environment/$ENV_NAME.json --agent_json ../jsonfiles/agent/$AGENT_NAME.json --index $SLURM_ARRAY_TASK_ID
