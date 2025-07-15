#!/bin/bash
#FLUX: --job-name=evasive-fudge-6867
#FLUX: --urgency=16

pythonmodule="Python/3.6.4-foss-2016b-fh1"
baseport=$(shuf -i 8786-60000 -n 1)
scriptn=${0##*/}
touser=$(/app/bin/fhrealuser)
debugto="petersen"
domain=$(hostname -d)
memlimit="16G"
if [[ "$scriptn" == "slurm_script" ]]; then
  scriptn="fhdask-test"
fi
if [[ -z $SLURM_CPUS_PER_TASK ]]; then
  SLURM_CPUS_PER_TASK="1"
fi
if [[ "$SLURM_JOB_PARTITION" == "largenode" ]]; then
  memlimit="33000"
fi
freeport(){
  local myport=$(( $1 + 1 ))
  while netstat -atwn | grep "^.*:${myport}.*:\*\s*LISTEN\s*$" > /dev/null; do
    myport=$(( ${myport} + 1 ))
  done
  echo "${myport}"
}
echoerr(){
  # echo to stderr instead of stdout
  echo -e "$@" 1>&2
}
if ! hash dask-scheduler 2>/dev/null; then
  source /app/bin/fhmodulecheck
  echoerr "No dask environment found, wrong python "
  echoerr "Please execute first: ml $pythonmodule"
  exit 1
fi
port=$(freeport $baseport)
bokehport=$(freeport $port)
echo "*** Dask ***"
echo "SCHEDULER ${SLURMD_NODENAME}:${port}"
echo "BOKEH ${SLURMD_NODENAME}:${bokehport}"
dask-scheduler --port ${port} --bokeh-port ${bokehport} --host $SLURMD_NODENAME --pid-file dask-scheduler.pid &
jobcfg=$(scontrol --oneliner show job $SLURM_JOB_ID)
jobcfg=${jobcfg##*NumCPUs=}
cpualloc=${jobcfg%%CPUs*}
mytasks=$SLURM_NTASKS
mytasks=$((cpualloc/SLURM_CPUS_PER_TASK))
if [[ -n $1 ]]; then
  # starting as many dask workers as tasks allocated (background)
  echoerr "starting ${mytasks} dask workers with ${SLURM_CPUS_PER_TASK} cores each in the background"
  srun --ntasks ${mytasks} --cpus-per-task ${SLURM_CPUS_PER_TASK} dask-worker --nthreads ${SLURM_CPUS_PER_TASK} --memory-limit ${memlimit} --local-directory ${SCRATCH} ${SLURMD_NODENAME}:${port} &
  if [[ -f $1 ]]; then
    echoerr "launching script file $1 ${SLURMD_NODENAME}:${port} as fhdask argument"
    $1 ${SLURMD_NODENAME}:${port} $2 $3 $4
  else
    echoerr "Error: script file $1 in fhdask argument not found."
  fi
  # terminate dask cluster after script has run
  sleep 15
  rm dask-scheduler.pid
  mpack -s "${scriptn}: run by ${touser}" ${SLURM_JOB_ID}.dask.err "${debugto}@${domain}"
else
  # starting as many dask workers as tasks allocated (foreground)
  echoerr "starting ${mytasks} dask workers on ${SLURM_NNODES} nodes with ${SLURM_CPUS_PER_TASK} cores each in the foreground"
  echoerr "use scancel ${SLURM_JOB_ID} to end this Dask job"
  # --nodes ${numnodes}
  srun --ntasks ${mytasks} --cpus-per-task ${SLURM_CPUS_PER_TASK}  dask-worker --nthreads ${SLURM_CPUS_PER_TASK} --memory-limit ${memlimit} --local-directory ${SCRATCH} ${SLURMD_NODENAME}:${port}
fi
exit 0
