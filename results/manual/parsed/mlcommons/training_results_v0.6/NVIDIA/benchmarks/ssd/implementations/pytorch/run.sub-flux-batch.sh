#!/bin/bash
#FLUX: --job-name=single_stage_detector
#FLUX: --exclusive
#FLUX: --queue=mlperf
#FLUX: -t=43200
#FLUX: --urgency=16

export MLPERF_HOST_OS='$(cat /etc/issue | head -1 | cut -f1-3 -d" ") / $(cat /etc/dgx-release | grep -E "DGX_PRETTY_NAME|DGX_OTA_VERSION" |cut -f2 -d= |cut -f2 -d '"' |paste -sd' ')'

DATESTAMP=${DATESTAMP:-`date +'%y%m%d%H%M%S%N'`}
BENCHMARK=${BENCHMARK:-"single_stage_detector"}
BENCHMARK_NAME="SSD"
CONT=${CONT:-"mlperf-nvidia:$BENCHMARK"}
DATADIR=${DATADIR:-"/raid/data/coco-2017"} # there should be ./coco2017 and ./torchvision dirs in here
LOGDIR=${LOGDIR:-"/raid/results/$BENCHMARK"}
NEXP=${NEXP:-5} # Default number of times to run the benchmark
SYSLOGGING=1
SYS_LOG_GET="'import mlperf_compliance; from mlperf_log_utils import mlperf_submission_log; mlperf_submission_log(mlperf_compliance.constants.$BENCHMARK_NAME)'"
DGXSYSTEM=${DGXSYSTEM:-"DGX1"}
if [[ ! -f "config_${DGXSYSTEM}.sh" ]]; then
  echo "Unknown system, assuming DGX1"
  DGXSYSTEM="DGX1"
fi
source config_${DGXSYSTEM}.sh
IBDEVICES=${IBDEVICES:-$DGXIBDEVICES}
INSLURM=1
if [[ -z "$SLURM_JOB_ID" ]]; then
  INSLURM=0
  export SLURM_JOB_ID="${DATESTAMP}"
  export SLURM_NNODES=1
else
  env | grep SLURM
fi
if [[ -z "SLURM_JOB_ID" || $SLURM_NNODES -eq 1 ]]; then
  # don't need IB if not multi-node
  export IBDEVICES=""
fi
LOGFILE_BASE="${LOGDIR}/${DATESTAMP}"
mkdir -p $(dirname "${LOGFILE_BASE}")
CONTVOLS="-v $DATADIR:/data -v $LOGDIR:/results"
NV_GPU="${NVIDIA_VISIBLE_DEVICES:-$(seq 0 $((${SLURM_NTASKS_PER_NODE:-${DGXNGPU}}-1)) | tr '\n' ',' | sed 's/,$//')}"
DOCKEREXEC="env NV_GPU=${NV_GPU} nvidia-docker run --init --rm --net=host --uts=host --ipc=host --ulimit stack=67108864 --ulimit memlock=-1 --name=cont_${SLURM_JOB_ID} --security-opt seccomp=unconfined $IBDEVICES"
export MLPERF_HOST_OS="$(cat /etc/issue | head -1 | cut -f1-3 -d" ") / $(cat /etc/dgx-release | grep -E "DGX_PRETTY_NAME|DGX_OTA_VERSION" |cut -f2 -d= |cut -f2 -d '"' |paste -sd' ')"
MASTER_IP=`getent hosts \`hostname\` | cut -d ' ' -f1`
PORT=$((4242 + RANDOM%1000))
SSH=''
SRUN=''
if [[ $INSLURM -eq 1 ]]; then
  hosts=( `scontrol show hostname |tr "\n" " "` )
  SSH='ssh -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $hostn'
  SRUN='srun --mem=0 -N 1 -n 1 -w $hostn'
else
  hosts=( `hostname` )
fi
if [[ "${PULL}" != "0" ]]; then
  DOCKERPULL="docker pull $CONT"
  pids=();
  for hostn in ${hosts[@]}; do
    timeout -k 600s 600s \
      $(eval echo $SRUN) $DOCKERPULL &
    pids+=($!);
  done
  wait "${pids[@]}"
  success=$? ; if [ $success -ne 0 ]; then echo "ERR: Image pull failed."; exit $success ; fi
fi
pids=();
for hostn in ${hosts[@]}; do
  timeout -k 600s 600s \
    $(eval echo $SRUN) $DOCKEREXEC $CONT python -c 'import torch; print("Found",torch.cuda.device_count(),"CUDA GPUs")' &
  pids+=($!);
done
wait "${pids[@]}"
success=$? ; if [ $success -ne 0 ]; then echo "ERR: Base container launch failed."; exit $success ; fi
pids=(); rets=()
for hostn in ${hosts[@]}; do
  $(eval echo $SSH) $DOCKEREXEC $CONTVOLS $CONT sleep infinity &
  pids+=($!); rets+=($?);
done
success=0; for s in ${rets[@]}; do ((success+=s)); done ; if [ $success -ne 0 ]; then echo "ERR: Container launch failed."; exit $success ; fi
sleep 30 # Making sure containers have time to launch 
pids=(); rets=()
for hostn in ${hosts[@]}; do
  $(eval echo $SSH) docker exec cont_${SLURM_JOB_ID} rm -f /etc/shinit &
  pids+=($!);
done
wait "${pids[@]}"
export NEXP
for nrun in `seq 1 $NEXP`; do
  (
    echo "Beginning trial $nrun of $NEXP"
      export VARS=(
         "-e" "SLURM_NNODES=$SLURM_NNODES"
         "-e" "MLPERF_HOST_OS"
      )
    if [[ $SYSLOGGING -eq 1 ]]; then
        VARS_STR="${VARS[@]}"
        bash -c "echo -n 'Gathering sys log on ' && hostname && docker exec $VARS_STR cont_${SLURM_JOB_ID} python -c ${SYS_LOG_GET}"
        if [[ $? -ne 0 ]]; then
            echo "ERR: Sys log gathering failed."
            exit 1
        fi
    fi
  ## Clear RAM cache dentries and inodes
    echo "Clearing caches"
    LOG_COMPLIANCE="'import mlperf_compliance; mlperf_compliance.mlperf_log.mlperf_print(mlperf_compliance.constants.CACHE_CLEAR, value=True, stack_offset=0)'"
  pids=(); rets=()
  for hostn in ${hosts[@]}; do
      if [[ $INSLURM -eq 1 ]]; then
        $(eval echo $SSH) bash -c 'sync && sudo /sbin/sysctl vm.drop_caches=3' && \
        $(eval echo $SSH) docker exec cont_${SLURM_JOB_ID} python -c $LOG_COMPLIANCE &
      else
        docker run --init --rm --privileged --entrypoint bash $CONT -c "sync && echo 3 > /proc/sys/vm/drop_caches && python -c $LOG_COMPLIANCE || exit 1" &
      fi
    pids+=($!); rets+=($?);
  done
  wait "${pids[@]}"
  success=0; for s in ${rets[@]}; do ((success+=s)); done ; if [ $success -ne 0 ]; then echo "ERR: Cache clearing failed."; exit $success ; fi
  ## Launching benchmark
  pids=();
  export MULTI_NODE=''
  for h in `seq 0 $((SLURM_NNODES-1))`; do
      hostn="${hosts[$h]}"
    echo "Launching on node $hostn"
    if [[ $SLURM_NNODES -gt 1 ]]; then
      export MULTI_NODE=" --nnodes=$SLURM_NNODES --node_rank=$h --master_addr=$MASTER_IP --master_port=$PORT"
    else
      export MULTI_NODE=" --master_port=$PORT"
    fi
      export DOCKERENV=(
         "-e" "DGXSYSTEM=$DGXSYSTEM"
         "-e" "MULTI_NODE=$MULTI_NODE"
         "-e" "SLURM_JOB_ID=$SLURM_JOB_ID"
         "-e" "SLURM_NTASKS_PER_NODE=$SLURM_NTASKS_PER_NODE"
      )
      # Execute command
      set -x
      $(eval echo $SRUN) docker exec "${DOCKERENV[@]}" cont_${SLURM_JOB_ID} ./run_and_time.sh &
    pids+=($!);
      set +x
  done
  wait "${pids[@]}"
  ) |& tee ${LOGFILE_BASE}_$nrun.log
done
if [[ $INSLURM -eq 0 ]]; then
  docker rm -f cont_${SLURM_JOB_ID}
fi
