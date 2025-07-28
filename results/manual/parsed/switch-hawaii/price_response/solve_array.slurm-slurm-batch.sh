#!/bin/bash
#FLUX: --job-name=demand_scenarios
#FLUX: --queue=community.q
#FLUX: -t=259200
#FLUX: --urgency=16

scen_name=$(awk -v line="${SLURM_ARRAY_TASK_ID}" -v field="2" 'NR==line{print $field}' scenarios_2018_04_29_theta01.txt)
echo "Solving scenario $scen_name."
module load lang/Python/2.7.10/python
srun --unbuffered --time=3-00:00:00 --partition=community.q switch solve-scenarios --scenario $scen_name --scenario-queue sq/sq_$SLURM_ARRAY_JOB_ID "$@" --tempdir ./tmp
