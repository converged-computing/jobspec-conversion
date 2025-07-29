#!/bin/bash
#FLUX: --job-name=SerialGNUParallel
#FLUX: -n=28
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

if [ -f  /etc/profile ]; then
    .  /etc/profile
fi
[ -n "${OAR_NODEFILE}" ]       && NB_CORES_HEADNODE=$(cat ${OAR_NODEFILE} | uniq -c | head -n1 | awk '{print $1}')
[ -n "${SLURM_CPUS_ON_NODE}" ] && NB_CORES_HEADNODE=$SLURM_CPUS_ON_NODE
: ${NB_CORES_HEADNODE:=1}
TASK="$HOME/mytask.sh"
ARG_TASK_FILE=
[ -n "${ARG_TASK_FILE}" ] && NB_TASKS=$(wc -l ${ARG_TASK_FILE}) || NB_TASKS=$(( 2*NB_CORES_HEADNODE ))
for m in ${MODULE_TO_LOAD[*]}; do
    module load $m
done
cd $WORK
if [ -z "${ARG_TASK_FILE}" ]; then
    # ============
    #  Example 1:
    # ============
    # use GNU parallel to perform the tasks on the node to run in
    # parallel on the ${NB_CORES_HEADNODE} cores:
    #    ${TASK} 1
    #    ${TASK} 2
    #    [...]
    #    ${TASK} ${NB_TASKS}
    seq ${NB_TASKS} | parallel -u -j ${NB_CORES_HEADNODE} ${TASK} {}
else
    # ============
    #  Example 2:
    # ============
    # use GNU parallel to perform the tasks on the node to run in
    # parallel on the ${NB_CORES_HEADNODE} cores for each line of
    # ${ARG_TASK_FILE} :
    #    ${TASK} <line1>
    #    ${TASK} <line2>
    #    [...]
    #    ${TASK} <lastline>
    cat ${ARG_TASK_FILE} | parallel -u -j ${NB_CORES_HEADNODE} --colsep ' ' ${TASK} {}
    # OR
    # parallel -u -j ${NB_CORES_HEADNODE} --colsep ' ' -a ${ARG_TASK_FILE} ${TASK} {}
fi
