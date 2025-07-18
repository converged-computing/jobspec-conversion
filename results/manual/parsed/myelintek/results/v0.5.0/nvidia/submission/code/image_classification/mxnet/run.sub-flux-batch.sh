#!/bin/bash
#FLUX: --job-name=image_classification
#FLUX: --exclusive
#FLUX: --queue=mlperf
#FLUX: -t=43200
#FLUX: --urgency=16

export VOLS='-v $DATADIR:/data -v $LOGDIR:/results'
export CONTNAME='mpi_${SLURM_JOB_ID}'
export DOCKEREXEC='docker run --rm --runtime nvidia --net=host --uts=host --ipc=host --ulimit stack=67108864 --ulimit memlock=-1 --security-opt seccomp=unconfined  $IBDEVICES'
export MASTER_HOST='${hosts[0]}'

DATESTAMP=${DATESTAMP:-`date +'%y%m%d%H%M%S'`}
BENCHMARK=${BENCHMARK:-"image_classification"}
BENCHMARK_NAME="resnet"
CONT=${CONT:-"mlperf-nvidia:$BENCHMARK"}
DATADIR=${DATADIR:-"/raid/data/imagenet/train-val-recordio-passthrough"} 
LOGDIR=${LOGDIR:-"/raid/results/$BENCHMARK"}
NEXP=${NEXP:-1} # Default number of times to run the benchmark
DGXSYSTEM=${DGXSYSTEM:-"DGX1"}
if [[ ! -f "config_${DGXSYSTEM}.sh" ]]; then
  echo "Unknown system, assuming DGX1"
  DGXSYSTEM="DGX1"
fi
source config_${DGXSYSTEM}.sh
export DGXSYSTEM
IBDEVICES=${IBDEVICES:-$DGXIBDEVICES}
INSLURM=1
if [[ -z "$SLURM_JOB_ID" ]]; then
  INSLURM=0
  export SLURM_JOB_ID="${DATESTAMP}"
  export SLURM_NNODES=1
fi
if [[ -z "SLURM_JOB_ID" || $SLURM_NNODES -eq 1 ]]; then
  # don't need IB if not multi-node
  export IBDEVICES=""
fi
LOGFILE_BASE="${LOGDIR}/${DATESTAMP}"
mkdir -p $(dirname "${LOGFILE_BASE}")
export VOLS="-v $DATADIR:/data -v $LOGDIR:/results"
export CONTNAME="mpi_${SLURM_JOB_ID}"
export DOCKEREXEC="docker run --rm --runtime nvidia --net=host --uts=host --ipc=host --ulimit stack=67108864 --ulimit memlock=-1 --security-opt seccomp=unconfined  $IBDEVICES"
DEBUG=0  # 1 = Print verbose messages for debugging
if [[ "$KVSTORE" == "horovod" ]]; then
  MPICMD="mpirun --allow-run-as-root --tag-output --bind-to none -x SLURM_NTASKS_PER_NODE=$SLURM_NTASKS_PER_NODE -x GPUS=$GPUS -x BATCHSIZE=$BATCHSIZE -x KVSTORE=$KVSTORE -x LR=$LR -x WARMUP_EPOCHS=$WARMUP_EPOCHS -x EVAL_OFFSET=$EVAL_OFFSET -x DGXSYSTEM=$DGXSYSTEM ./run_and_time.sh"
else
  MPICMD="./run_and_time.sh"
fi
mkdir -m 777 -p $LOGDIR
echo $MPICMD | tee -a $LOGDIR/$DATESTAMP.log 
MASTER_IP=`getent hosts \`hostname\` | cut -d ' ' -f1`
SSH=''
SRUN=''
if [[ $INSLURM -eq 0 ]]; then
  export hosts=( `hostname` )
else
  export hosts=( `scontrol show hostname |tr "\n" " "` )
  SSH='ssh -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $hostn'
  SRUN='srun -N 1 -n 1 -w $hostn'
fi
unique_hosts=( $(echo "${hosts[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ' ) )
export MASTER_HOST=${hosts[0]}
VARS="-e OMPI_MCA_mca_base_param_files=/dev/shm/mpi/${SLURM_JOB_ID}/mca_params.conf -e GPUS -e BATCHSIZE -e KVSTORE -e LR -e WARMUP_EPOCHS -e EVAL_OFFSET -e CONT -e DGXSYSTEM=$DGXSYSTEM -e MASTER_HOST -e MASTER_IP -e SLURM_JOB_NUM_NODES -e SLURM_NNODES -e SLURM_NTASKS_PER_NODE "
RUNSLEEPCMD=""
[[ "${PULL}" -eq "1" ]] && docker pull $CONT
if [[ "$KVSTORE" == "horovod" ]]; then
  # Make keys and copy
  echo
  [[ $DEBUG == 1 ]] && echo "Setting up ssh keys and config"
  mkdir -p ${HOME}/.ssh/sbatch/${SLURM_JOB_ID}
  ssh-keygen -t rsa -b 2048 -n "" -f "${HOME}/.ssh/sbatch/${SLURM_JOB_ID}/sshkey.rsa" -C "mxnet_${SLURM_JOB_ID}_"  &>/dev/null
  echo command=\"/dev/shm/mpi/${SLURM_JOB_ID}/sshentry.sh\",no-port-forwarding,no-agent-forwarding,no-X11-forwarding $(cat ${HOME}/.ssh/sbatch/${SLURM_JOB_ID}/sshkey.rsa.pub) >> ${HOME}/.ssh/authorized_keys
  chmod 600 ~/.ssh/authorized_keys
  [[ $DEBUG == 1 ]] && echo "Copy keys: srun -n $SLURM_JOB_NUM_NODES mkdir /dev/shm/mpi && cp -R ${HOME}/.ssh/sbatch/${SLURM_JOB_ID} /dev/shm/mpi && chmod 700 /dev/shm/mpi/${SLURM_JOB_ID}" 
  srun  -n $SLURM_JOB_NUM_NODES --ntasks-per-node=1 bash -c "mkdir -p /dev/shm/mpi/${SLURM_JOB_ID}; cp -R ${HOME}/.ssh/sbatch/${SLURM_JOB_ID} /dev/shm/mpi; chmod 700 /dev/shm/mpi/${SLURM_JOB_ID}"
  sleep 2 # Making copy
  [[ $DEBUG == 1 ]] && ls /dev/shm
  # Create mpi config file
  srun  -n $SLURM_JOB_NUM_NODES --ntasks-per-node=1 tee /dev/shm/mpi/${SLURM_JOB_ID}/mca_params.conf <<EOF
plm_rsh_agent = /usr/bin/ssh
plm_rsh_args = -i /dev/shm/mpi/${SLURM_JOB_ID}/sshkey.rsa -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oLogLevel=ERROR -l ${USER}
orte_default_hostfile = /dev/shm/mpi/${SLURM_JOB_ID}/mpi_hosts
btl_openib_warn_default_gid_prefix = 0
mpi_warn_on_fork = 0
allow_run_as_root = 1
EOF
  [[ $DEBUG == 1 ]] && echo "::mca_params.conf=" && cat /dev/shm/mpi/${SLURM_JOB_ID}/mca_params.conf
  # Create ssh helper script that transfers an ssh into a compute node into the running container on that node
  srun -n $SLURM_JOB_NUM_NODES --ntasks-per-node=1 tee /dev/shm/mpi/${SLURM_JOB_ID}/sshentry.sh <<EOF
echo "::sshentry: entered \$(hostname)"
[[ -f $CONTNAME ]] && "::worker container not found error" && exit 1
echo "::sshentry: running \$SSH_ORIGINAL_COMMAND"
exec docker exec $CONTNAME /bin/bash -c "\$SSH_ORIGINAL_COMMAND"
EOF
  [[ $DEBUG == 1 ]] && echo "::sshentry=" && cat /dev/shm/mpi/${SLURM_JOB_ID}/sshentry.sh
  # Create mpi hostlist
  for h in ${hosts[@]}; do
     echo "$h slots=${SLURM_NTASKS_PER_NODE}" >> /dev/shm/mpi/${SLURM_JOB_ID}/mpi_hosts
  done
  [[ $DEBUG == 1 ]] && echo '::mpi-host file=' && cat /dev/shm/mpi/${SLURM_JOB_ID}/mpi_hosts
  srun -n $SLURM_JOB_NUM_NODES --ntasks-per-node=1 bash -c "cp $(which ssh) /dev/shm/mpi/${SLURM_JOB_ID}/.;  chmod 755 /dev/shm/mpi/${SLURM_JOB_ID}/mca_params.conf;  chmod 755 /dev/shm/mpi/${SLURM_JOB_ID}/sshentry.sh"
  # Check that ssh/mpi dir has correct number of files
  [[ $(ls /dev/shm/mpi/${SLURM_JOB_ID} | wc -w) -lt 5 ]]  && echo "ERR: /dev/shm/mpi/${SLURM_JOB_ID} doesn't exist or missing ssh/mpi files" && exit $?
fi
if [[ $INSLURM -eq 1 ]]; then
  # Launch containers behind srun
  [[ $DEBUG == 1 ]] && echo "" && echo ":Launch containers:  srun  -n $SLURM_JOB_NUM_NODES --ntasks-per-node=1 $DOCKEREXEC --name $CONTNAME $VOLS $VARS $CONT bash -c 'sleep infinity'"
  srun  -n $SLURM_JOB_NUM_NODES --ntasks-per-node=1 $DOCKEREXEC --name $CONTNAME $VOLS $VARS $CONT bash -c 'sleep infinity' & rv=$?
else
  $DOCKEREXEC --name $CONTNAME $VOLS $VARS $CONT bash -c 'sleep infinity' & rv=$?
fi
[[ $rv -ne 0 ]] && echo "ERR: Launch sleep containers failed." && exit $rv
sleep 30
export NEXP
for nrun in `seq 1 $NEXP`; do
  (
    echo "Beginning trial $nrun of $NEXP"
    # Clear RAM cache dentries and inodes
    [[ $DEBUG == 1 ]] && set -x
    echo "Clearing caches"
    LOG_COMPLIANCE="'from mlperf_compliance import mlperf_log as log; log.${BENCHMARK_NAME}_print(key=log.RUN_CLEAR_CACHES)'"
  pids=(); rets=()
  for hostn in ${unique_hosts[@]}; do
      echo " - Clearing cache on ${hostn}"
      if [[ $INSLURM -eq 1 ]]; then
        $(eval echo $SSH) bash -c 'sync && sudo /sbin/sysctl vm.drop_caches=3' && \
        $(eval echo $SSH) docker exec $CONTNAME python -c $LOG_COMPLIANCE &
      else
        docker run --rm --privileged --entrypoint bash $CONT -c "sync && echo 3 > /proc/sys/vm/drop_caches && python -c $LOG_COMPLIANCE || exit 1" &
      fi
    pids+=($!); rets+=($?);
  done
  wait "${pids[@]}"
  success=0; for s in ${rets[@]}; do ((success+=s)); done ; if [ $success -ne 0 ]; then echo "ERR: Cache clearing failed."; exit $success ; fi
  # Launching app
  echo 
  echo "Launching user script on master node:"
    hostn=$MASTER_HOST
  $(eval echo $SSH) docker exec $VARS $CONTNAME $MPICMD ; rv=$?
  [[ $rv -ne 0 ]] && echo "ERR: User script failed." && exit $rv
  ) |& tee ${LOGFILE_BASE}_$nrun.log
done
if [[ $INSLURM -eq 0 ]]; then
  docker rm -f $CONTNAME
fi
