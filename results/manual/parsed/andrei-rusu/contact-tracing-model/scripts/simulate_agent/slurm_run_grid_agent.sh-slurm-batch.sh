#!/bin/bash
#FLUX: --job-name=Epidemic Grid Simulation with Agent
#FLUX: -t=2700
#FLUX: --urgency=16

export MPLBACKEND='Agg'
export CUBLAS_WORKSPACE_CONFIG=':4096:8'

if [ -n "$SLURM_JOB_ID" ]; then
    echo "Running in SLURM with job ID: $SLURM_JOB_ID"
    module load conda
    source activate contact
else
    echo "Running locally, default SLURM job ID to 0"
    SLURM_JOB_ID=0
    SLURM_SUBMIT_DIR=.
fi
cd $SLURM_SUBMIT_DIR
if [ -z "$SLURM_ARRAY_TASK_ID" ]; then
    SLURM_ARRAY_TASK_ID=0
fi
JOB_ID=$SLURM_JOB_ID
TASK_ID=$SLURM_ARRAY_TASK_ID
export MPLBACKEND=Agg
export CUBLAS_WORKSPACE_CONFIG=":4096:8"
gridentry=($(python ../paramgrid.py --id $SLURM_ARRAY_TASK_ID --sample 10))
python -m ct_simulator.run_tracing -a temp/agent_$TASK_ID.json -r temp/amodel_$TASK_ID.json \
    --exp-id "slurm_agent_"$JOB_ID"" \
    --nettype "barabasi:5:1" \
    --reindex False \
    --netsize 100 \
    --k 2.8 \
    --p .1 \
    --rem_orphans False \
    --use_weights True \
    --dual 0 \
    --control_schedule 2 0.5 0.99 \
    --control_after ${gridentry[1]} \
    --control_after_inf .05 \
    --control_initial_known ${gridentry[0]} \
    --control_gpu 0 \
    --first_inf 5 \
    --taut 0 \
    --taur 0 \
    --sampling_type "min" \
    --presample 10000 \
    --model "seir" \
    --spontan False \
    --pa=.2 \
    --update_after 1 \
    --summary_splits 20 \
    --noncomp 0 \
    --noncomp_after 10000 \
    --avg_without_earlystop True \
    --multip 0 \
    --nnets 1 \
    --niters 1 \
    --infseed -1 \
    --seed $TASK_ID \
    --netseed 11 \
    --animate 0 \
    --summary_print 3
