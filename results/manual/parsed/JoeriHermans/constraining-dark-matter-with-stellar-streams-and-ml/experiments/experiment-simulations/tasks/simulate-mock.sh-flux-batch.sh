#!/bin/bash
#FLUX: --job-name=STREAM_SIMULATE_MOCK
#FLUX: -c=2
#FLUX: -t=604800
#FLUX: --urgency=16

stream_index=$SLURM_ARRAY_TASK_ID
suffix=$(printf "%05d" $stream_index)
task_identifier="block-"$suffix
out=$DATADIR/mock/$task_identifier
mkdir -p $out
if [ ! -f $out/densities.npy -o $PROJECT_FORCE_RERUN -ne 0 ]; then
    # Compute the number of required simulations.
    python -u simulate.py \
           --mocks $EXPERIMENT_MOCKS \
           --mock-index $SLURM_ARRAY_TASK_ID \
           --out $out \
           --size 1
fi
