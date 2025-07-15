#!/bin/bash
#FLUX: --job-name=Epidemic Grid Simulation on SocialEvolution
#FLUX: -t=900
#FLUX: --urgency=16

export MPLBACKEND='Agg'

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
gridentry=($(python ../paramgrid.py --id $SLURM_ARRAY_TASK_ID))
uptake=${gridentry[0]}
taut=${gridentry[1]}
taur=${gridentry[2]}
pa=${gridentry[3]}
overlap=${gridentry[4]}
group=${gridentry[5]}
dual=${gridentry[6]}
if [ $taut -eq 10 ]
then
    taut=(0 .1 .2 .5 1.0 1.5 2.0)
fi
export MPLBACKEND=Agg
python -m ct_simulator.run_tracing \
    --exp-id "socialevol_"$JOB_ID"" \
    --nettype "socialevol::40,70,w" \
    --use_weights True \
    --K_factor 10 \
    --update_after 1 \
    --multip 3 \
    --model "covid" \
    --dual $dual \
    --uptake $uptake \
    --overlap 1 \
    --maintain_overlap False \
    --overlap_two $overlap \
    --maintain_overlap_two True \
    --nnets 10 \
    --niters 150 \
    --separate_traced True \
    --avg_without_earlystop True \
    --trace_after 3 \
    --first_inf .1 \
    --earlystop_margin 5 \
    --rem_orphans False \
    --noncomp .001 \
    --noncomp_after 14 \
    --presample 100000 \
    --pa $pa \
    --taut ${taut[@]} \
    --delay_two 2. \
    --taur $taur \
    --sampling_type "min" \
    --infseed -1 \
    --seed $TASK_ID \
    --netseed 11 \
    --animate 0 \
    --summary_print 3
