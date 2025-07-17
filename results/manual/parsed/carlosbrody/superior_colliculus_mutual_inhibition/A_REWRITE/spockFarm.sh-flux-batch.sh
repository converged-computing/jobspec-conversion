#!/bin/bash
#FLUX: --job-name=spockFarm
#FLUX: --queue=Brody
#FLUX: -t=345600
#FLUX: --urgency=16

module load julia/1.2.0
echo "Slurm Job ID, unique: $SLURM_JOB_ID"
echo "Slurm Array Task ID, relative: $SLURM_ARRAY_TASK_ID"
juliaScript=$1
shift
taskIDOffset=175
julia $juliaScript --bspockID ${SLURM_ARRAY_JOB_ID}_$SLURM_ARRAY_TASK_ID --myRunNumber $((SLURM_ARRAY_TASK_ID + taskIDOffset)) --onSpock --hostname spock $@
