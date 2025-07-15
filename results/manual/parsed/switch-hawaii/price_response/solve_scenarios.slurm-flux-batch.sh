#!/bin/bash
#FLUX: --job-name=demand_scenarios
#FLUX: --queue=shared
#FLUX: -t=259200
#FLUX: --priority=16

module load lang/Anaconda3
source activate demand_system
echo ============================================================
echo running job: switch solve-scenarios --scenario-queue sq/$SLURM_ARRAY_JOB_ID --job-id "$SLURM_ARRAY_JOB_ID"_"$SLURM_ARRAY_TASK_ID" "$@" --tempdir ./tmp
echo ============================================================
echo
srun --unbuffered switch solve-scenarios --scenario-queue sq/$SLURM_ARRAY_JOB_ID --job-id "$SLURM_ARRAY_JOB_ID"_"$SLURM_ARRAY_TASK_ID" "$@" --tempdir ./tmp
