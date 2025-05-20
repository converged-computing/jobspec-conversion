#!/bin/bash
#FLUX: -N 1                  # Each task runs on 1 node
#FLUX: -n 1                  # This script represents 1 task
#FLUX: -c 1                  # Request 1 core per task
#FLUX: --requires=mem=120G   # Request 120GB memory per task (on its node)
#FLUX: -t 12:00:00           # Walltime of 12 hours

# Note on Slurm partitions (-p astyanax,small,amdsmall,cavefish):
# Flux does not use named partitions in the same way. If these partitions
# correspond to specific hardware features (e.g., CPU type, interconnect, specific nodes),
# you would use Flux constraints. For example:
# #FLUX: --requires=haswell  (if 'small' partition means Haswell nodes)
# #FLUX: --requires=cpu_vendor:amd (if 'amdsmall' means AMD CPUs)
# Without specific knowledge of what these Slurm partitions represent,
# they are not directly translated here. Flux will use available resources
# matching other constraints.

# This script is intended to be run as part of a Flux "job array" or bulk submission.
# For example, submitting 23 such tasks:
# flux submit --ntasks=23 ./this_script_name.sh
#
# Inside the script, FLUX_TASK_RANK (0-indexed) corresponds to SLURM_ARRAY_TASK_ID (1-indexed).

cd /home/mcgaughs/shared/Software/diploSHIC
discoal="/home/mcgaughs/shared/Software/discoal/discoal"


CMD_LIST="Surface_discoal_commands_w_3popsizes_2.txt"
#CMD_LIST="discoal_commands_orig_params_w_popsize.txt"

# SLURM_ARRAY_TASK_ID is 1-indexed. FLUX_TASK_RANK is 0-indexed.
# Ensure FLUX_TASK_RANK is set (e.g., when submitted via flux submit --ntasks=N)
if [ -z "${FLUX_TASK_RANK}" ]; then
  echo "Error: FLUX_TASK_RANK is not set. This script should be run as a Flux job task." >&2
  # Default to 0 for testing, or exit
  # exit 1
  FLUX_TASK_RANK=0 # Or handle error appropriately
  echo "Warning: FLUX_TASK_RANK was not set, defaulting to 0 for this run." >&2
fi

CURRENT_TASK_ID=$((FLUX_TASK_RANK + 1))

CMD="$(sed "${CURRENT_TASK_ID}q;d" ${CMD_LIST})"

# Echo the command to be run for logging purposes (optional)
echo "Flux Task Rank: ${FLUX_TASK_RANK}, Effective ID: ${CURRENT_TASK_ID}"
echo "Executing command: ${CMD}"

eval ${CMD}

```