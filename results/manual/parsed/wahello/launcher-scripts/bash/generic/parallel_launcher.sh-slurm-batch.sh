#!/bin/bash
#FLUX: --job-name=GNUParallel
#FLUX: -N=2
#FLUX: -n=56
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

if [ -f  /etc/profile ]; then
    .  /etc/profile
fi
if [ -n "$OAR_JOBID" ] ; then
  NODEFILE=$OAR_NODEFILE
  JOBID=$OAR_JOBID
  GP_WRAPPER=gpoarsh
elif [ -n "$SLURM_JOBID" ] ; then
  NODEFILE=/tmp/slurm_nodefile_$SLURM_JOBID
  srun hostname | sort -n > $NODEFILE
  JOBID=$SLURM_JOBID
  GP_WRAPPER=gpssh
fi
NB_HOSTS=$(cat ${NODEFILE} | uniq | wc -l)
TASK="$HOME/mytask.sh"
ARG_TASK_FILE=
[ -n "${ARG_TASK_FILE}" ] && NB_TASKS=$(wc -l ${ARG_TASK_FILE}) || NB_TASKS=$(( 2*NB_HOSTS ))
NB_CORE_PER_TASK=6
GP_SSHLOGINFILE=/tmp/gnuparallel_hostfile.${JOBID}
GP_OPTS=
GP_WRAPPER_FILE=/opt/apps/wrappers/${GP_WRAPPER}
[ ! -f ${GP_WRAPPER_FILE} ] && GP_WRAPPER_FILE=$(git rev-parse --show-toplevel)/wrappers/${GP_WRAPPER}
[ ! -f ${GP_WRAPPER_FILE} ] && echo "Could not find the wrapper script 'gpoarsh'!"  && exit 1
for m in ${MODULE_TO_LOAD[*]}; do
    module load $m
done
cd $WORK
JOBMODULELIST="$(printf :%s ${MODULE_TO_LOAD[@]})"
cat $NODEFILE | awk -v gpw=$GP_WRAPPER_FILE -v jml=$JOBMODULELIST '{printf "%s %s %s\n", gpw, jml, $1}' > ${GP_SSHLOGINFILE}.core
cat $NODEFILE | uniq -c | awk -v gpw=$GP_WRAPPER_FILE -v jml=$JOBMODULELIST '{printf "%s/%s %s %s\n", $1, gpw, jml, $2}' > ${GP_SSHLOGINFILE}.node
cat $NODEFILE | uniq -c | while read line; do
    NB_CORE=$(echo $line  | awk '{ print $1 }')
    HOSTNAME=$(echo $line | awk '{ print $2 }')
    n=$(( NB_CORE/NB_CORE_PER_TASK ))
    # If NB_CORE is divisible by NB_CORE_PER_TASK, n remain unchanged, e.g., n = 6/6 = 1
    # Otherwise, n = NB_CORE/NB_CORE_PER_TASK + 1, e.g., n = 1/6+1 = 0+1 = 1
    # To make sure at least one ${GP_SSHLOGINFILE}.task will be created.
    k=$(( n*NB_CORE_PER_TASK ))
    if [ $k -ne ${NB_CORE} ];then
        n=$(( n+1 ))
    fi
    SSHLOGIN="$n/$GP_WRAPPER_FILE $JOBMODULELIST $HOSTNAME"
    if [ $n -gt 0 ]; then
        echo "${SSHLOGIN}" >> ${GP_SSHLOGINFILE}.task
        GP_SSHLOGIN_OPT="${GP_SSHLOGIN_OPT} --sshlogin '${SSHLOGIN}'"
    fi
done
if [ -z "${ARG_TASK_FILE}" ]; then
    # ============
    #  Example 1:
    # ============
    # use GNU parallel to perform the tasks on the reserved nodes:
    #    ${TASK} 1
    #    ${TASK} 2
    #    [...]
    #    ${TASK} ${NB_TASKS}
    seq ${NB_TASKS} | parallel --tag -u  --sshloginfile ${GP_SSHLOGINFILE}.task ${GP_OPTS} ${TASK} {}
else
    # ============
    #  Example 2:
    # ============
    # use GNU parallel to perform the tasks on the nodes to run in
    # parallel on ${NB_CORE_PER_TASK} cores for each line of
    # ${ARG_TASK_FILE} :
    #    ${TASK} <line1>
    #    ${TASK} <line2>
    #    [...]
    #    ${TASK} <lastline>
    cat ${ARG_TASK_FILE} | parallel --tag -u  --sshloginfile ${GP_SSHLOGINFILE}.task --colsep '\n' ${GP_OPTS} ${TASK} {}
fi
[ -f "${GP_SSHLOGINFILE}.core" ] && rm -f ${GP_SSHLOGINFILE}.core
[ -f "${GP_SSHLOGINFILE}.node" ] && rm -f ${GP_SSHLOGINFILE}.node
[ -f "${GP_SSHLOGINFILE}.task" ] && rm -f ${GP_SSHLOGINFILE}.task
[ -n "$SLURM_JOBID"            ] && rm -f ${NODEFILE}
