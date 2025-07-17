#!/bin/bash
#FLUX: --job-name=boopy-peanut-4992
#FLUX: --queue=ci
#FLUX: -t=3600
#FLUX: --urgency=16

SCENARIO=$1
N_AGENTS=$2
PROBLEM_PARAMS=$3
source /opt/spack/main/env.sh
module load python
source venv/bin/activate
srun python -m polygonal_roadmaps -n_agents $N_AGENTS -index $SLURM_ARRAY_TASK_ID \
    -logfile "logs/$PLANNER$SCENARIO/$SLURM_ARRAY_TASK_ID.log" -loglevel warning -memlimit 5 -timelimit 30 \
    -planner $(ls benchmarks/planner_config) -scenario $SCENARIO -problem_parameters $PROBLEM_PARAMS
