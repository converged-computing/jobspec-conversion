#!/bin/bash
#FLUX: --job-name={{job_name}}
#FLUX: --queue={{partition}}
#FLUX: --urgency=16

export IPYTHONDIR='/tmp'

{{sbatch_resources}}
{{exclude_nodes}}
echo "linking job logs to terminal"
echo "=================================================================="
{{env_setup}}
worker_id=$((SLURM_ARRAY_TASK_ID - 1))
echo "This is SLURM task $SLURM_ARRAY_TASK_ID, worker id $worker_id"
declare -a custom_args_queue=({{job_queue}})
prep="{{prep}}"
echo "running prep cmd $prep"
eval "${prep}"
cmd="{{cmd}}"
cmd="srun --unbuffered ${cmd} ${custom_args_queue[${worker_id}]}"
echo "running cmd $cmd"
eval "${cmd}"
