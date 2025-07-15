#!/bin/bash
#FLUX: --job-name=fuzzy-lemon-0416
#FLUX: -t=3600
#FLUX: --urgency=16

if [ -f  /etc/profile ]; then
    .  /etc/profile
fi
[ -n "${OAR_NODEFILE}" ]       && NB_CORES_HEADNODE=$(cat ${OAR_NODEFILE} | uniq -c | head -n1 | awk '{print $1}')
[ -n "${SLURM_CPUS_ON_NODE}" ] && NB_CORES_HEADNODE=$SLURM_CPUS_ON_NODE
: ${NB_CORES_HEADNODE:=1}
TASK="$HOME/mytask.sh"
ARG_TASK_FILE=$HOME/mytask.args.example
[ -n "${ARG_TASK_FILE}" ] && NB_TASKS=$(wc -l ${ARG_TASK_FILE}) || NB_TASKS=$(( 2*NB_CORES_HEADNODE ))
for m in ${MODULE_TO_LOAD[*]}; do
    module load $m
done
cd $WORK
if [ -z "${ARG_TASK_FILE}" ]; then
    # ============
    #  Example 1:
    # ============
    # Run in a sequence:
    #    ${TASK} 1
    #    ${TASK} 2
    #    [...]
    #    ${TASK} ${NB_TASKS}
    for i in $(seq 1 ${NB_TASKS}); do
        ${TASK} $i
    done
else
    # ============
    #  Example 2:
    # ============
    # For each line of ${ARG_TASK_FILE}, run in a sequence:
    #    ${TASK} <line1>
    #    ${TASK} <line2>
    #    [...]
    #    ${TASK} <lastline>
    while read line; do
        ${TASK} $line
    done < ${ARG_TASK_FILE}
fi
