#!/bin/bash
#FLUX: --job-name=object_detection
#FLUX: -n=4
#FLUX: --exclusive
#FLUX: --queue=dedicateq
#FLUX: -t=43200
#FLUX: --urgency=16

set -euxo pipefail
: "${SYSTEM:?SYSTEM not set}"
: "${NEXP:=5}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${CLEAR_CACHES:=1}"
: "${DATADIR:=/mnt/isilon/DeepLearning/database/mlperf}"
: "${LOGDIR:=./results}"
NUM_NODES=$SLURM_JOB_NUM_NODES
CONT="sandbox-pytorch-ngc20.06"
readonly _logfile_base="${LOGDIR}/${DATESTAMP}"
MLPERF_HOST_OS=$(bash <<EOF
    source /etc/os-release
    echo "\${PRETTY_NAME}"
EOF
)
export MLPERF_HOST_OS
mkdir -p "${LOGDIR}"
for _experiment_index in $(seq 1 "${NEXP}"); do
    (
        echo "Beginning trial ${_experiment_index} of ${NEXP}"
        hosts=( `scontrol show hostname |tr "\n" " "` ) 
        for node_id in `seq 0 $(($NUM_NODES-1))`; do
            # print system info
            srun -N 1 -n 1 -w ${hosts[$node_id]}  singularity exec $CONT python -c \
                "from mlperf_logging.mllog import constants ; \
                 from maskrcnn_benchmark.utils.mlperf_logger import log_event; \
                 log_event(constants.MASKRCNN)" 
            echo "Clearning cache on each node"
            srun -N 1 -n 1 -w ${hosts[$node_id]} bash -c "sync && echo 3 | tee /proc/sys/vm/drop_caches"
            srun -N 1 -n 1 -w ${hosts[$node_id]} singularity exec $CONT python -c \
                "from mlperf_logging.mllog import constants; \
                 from maskrcnn_benchmark.utils.mlperf_logger import log_event; \
                 log_event(key=constants.CACHE_CLEAR, value=True, stack_offset=0)"
        done
        # Run experiment
	    #srun --mpi=none --ntasks=${SLURM_NTASKS}  \
        #    singularity exec -w -B /cm/local/apps/cuda/libs/current:/mnt/driver \
        #                        -B ${DATADIR}:/data -B ${PWD}:/mnt/current \
        #                        ${CONT} bash /mnt/current/run_and_time_multi.sh
        num_nodes=$SLURM_JOB_NUM_NODES 
        hosts=( `scontrol show hostname |tr "\n" " "` )
        pids=()
        for node_id in `seq 0 $(($num_nodes-1))`; do
            if [[ $num_nodes -gt 1 ]]; then
                master_addr="$(hostname).ib.cluster"
                export MULTI_NODE=" --nnodes=$num_nodes --node_rank=$node_id --master_addr=$master_addr --master_port=4242 "
            fi
            srun -N 1 -n 1 -w ${hosts[$node_id]} \
            singularity exec -w -B /cm/local/apps/cuda/libs/current:/mnt/driver \
                -B $DATADIR:/data  -B $PWD:/mnt/current \
                ${CONT} bash /mnt/current/run_and_time_multi.sh &
            pids+=($!);
        done
        sleep 10
        wait "${pids[@]}"
    ) |& tee "${_logfile_base}_${_experiment_index}.log"
done
