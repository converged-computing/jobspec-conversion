#!/bin/bash
#FLUX: --job-name=expressive-onion-2238
#FLUX: --priority=16

SING_BIND=$( python3 $HOME/parse_settings.py --BIND )
SIMG=$( python3 $HOME/parse_settings.py --SIMG )
echo "Job landed on $(hostname)"
pattern="*MHz*.parset"
files=( $pattern )
N=$(( ${SLURM_ARRAY_TASK_ID} ))
singularity exec -B $SING_BIND $SIMG DP3 ${files[${N}]}
echo "Launched script for ${files[${N}]}"
