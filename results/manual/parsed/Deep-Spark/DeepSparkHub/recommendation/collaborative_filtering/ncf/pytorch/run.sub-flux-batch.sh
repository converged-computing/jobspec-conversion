#!/bin/bash
#FLUX: --job-name=recommendation
#FLUX: --exclusive
#FLUX: --queue=mlperf
#FLUX: -t=43200
#FLUX: --urgency=16

DATESTAMP=${DATESTAMP:-`date +'%y%m%d%H%M%S'`}
BENCHMARK=${BENCHMARK:-"recommendation"}
BENCHMARK_NAME="ncf"
CONT=${CONT:-"mlperf-nvidia:$BENCHMARK"}
DATADIR=${DATADIR:-"/raid/data"} # location for ml-20m dataset to be preprocessed and stored
LOGDIR=${LOGDIR:-"/raid/results/$BENCHMARK"}
NEXP=${NEXP:-100} # Default number of times to run the benchmark
SEED=${SEED:-$(od -A n -t d -N 3 /dev/urandom)} # Allows passing SEED in, which is helpful if NEXP=1 ; for NEXP>1 we need to pick different seeds for subsequent runs
PREPROCESS=${PREPROCESS:-0} # don't preprocess by default; assume it's been done offline
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
fi
if [[ -z "SLURM_JOB_ID" || $SLURM_NNODES -eq 1 ]]; then
  # don't need IB if not multi-node
  export IBDEVICES=""
fi
LOGFILE_BASE="${LOGDIR}/${DATESTAMP}"
mkdir -p $(dirname "${LOGFILE_BASE}")
CONTVOLS="-v $DATADIR:/data -v $LOGDIR:/results"
NV_GPU="${NVIDIA_VISIBLE_DEVICES:-$(seq 0 $((${SLURM_NTASKS_PER_NODE:-${DGXNGPU}}-1)) | tr '\n' ',' | sed 's/,$//')}"
DOCKEREXEC="env NV_GPU=${NV_GPU} nvidia-docker run --rm --net=host --uts=host --ipc=host --ulimit stack=67108864 --ulimit memlock=-1 --name=cont_${SLURM_JOB_ID} --security-opt seccomp=unconfined $IBDEVICES"
MASTER_IP=`getent hosts \`hostname\` | cut -d ' ' -f1`
PORT=4242
SSH=''
SRUN=''
if [[ $INSLURM -eq 1 ]]; then
  hosts=( `scontrol show hostname |tr "\n" " "` )
  SSH='ssh -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $hostn'
  SRUN='srun -N 1 -n 1 -w $hostn'
else
  hosts=( `hostname` )
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
sleep 10 # Making sure containers have time to launch 
if [[ ${PREPROCESS} -eq 1 ]]; then
  ## note: this happens only on the first node (which is fine for NCF since it's single-node)
  pushd $DATADIR
  if [[ ! -f ./ml-20m.zip ]]; then
    curl -O http://files.grouplens.org/datasets/movielens/ml-20m.zip
  fi
  echo "Processing ratings.csv and saving to disk"
  unzip -u ml-20m.zip || exit 1
  popd
  t0=$(date +%s)
  hostn=${hosts[0]}
  $(eval echo $SRUN) docker exec cont_${SLURM_JOB_ID} python convert.py --path /data/ml-20m/ratings.csv --output /data/ml-20m/ >> log
  t1=$(date +%s)
  delta=$(( $t1 - $t0 ))
  echo "Finished processing in $delta seconds"
fi
export SEED
echo "Start ${NEXP} training tests"
export NEXP
for nrun in `seq 1 $NEXP`; do
  (
    echo "Beginning trial $nrun of $NEXP"
	## Clear RAM cache dentries and inodes
    echo "Clearing caches"
    LOG_COMPLIANCE="'from mlperf_compliance import mlperf_log as log; log.${BENCHMARK_NAME}_print(key=log.RUN_CLEAR_CACHES)'"
	pids=(); rets=()
	for hostn in ${hosts[@]}; do
      if [[ $INSLURM -eq 1 ]]; then
        $(eval echo $SSH) bash -c 'sync && sudo /sbin/sysctl vm.drop_caches=3' && \
        $(eval echo $SSH) docker exec cont_${SLURM_JOB_ID} python -c $LOG_COMPLIANCE &
      else
        docker run --rm --privileged --entrypoint bash $CONT -c "sync && echo 3 > /proc/sys/vm/drop_caches && python -c $LOG_COMPLIANCE || exit 1" &
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
	  fi
      export DOCKERENV=(
         "-e" "DGXSYSTEM=$DGXSYSTEM"
         "-e" "SEED=$SEED"
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
  ## SEED update
  export SEED=$(od -A n -t d -N 3 /dev/urandom)
done
if [[ $INSLURM -eq 0 ]]; then
  docker rm -f cont_${SLURM_JOB_ID}
fi
