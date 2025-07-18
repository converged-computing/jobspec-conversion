#!/bin/bash
#FLUX: --job-name=dlrm.hugectr
#FLUX: -t=1800
#FLUX: --urgency=16

set -euxo pipefail
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${CONT:?CONT not set}"
: "${NEXP:=5}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${CLEAR_CACHES:=1}"
: "${MOUNTS:='/raid/datasets:/raid/datasets,/gpfs/fs1:/gpfs/fs1'}"
: "${LOGDIR:=./results}"
readonly _config_file="./config_${DGXSYSTEM}.sh"
readonly _logfile_base="${LOGDIR}/${DATESTAMP}"
readonly _cont_name=dlrm_hugectr
_cont_mounts=("--volume=${DATADIR}:/raid/datasets/criteo/mlperf/40m.limit_preshuffled/" "--volume=${LOGDIR}:${LOGDIR}" "--volume=$(pwd):/workspace/dlrm")
mkdir -p "${LOGDIR}"
source "${_config_file}"
mapfile -t _config_env < <(env -i bash -c ". ${_config_file} && compgen -e" | grep -E -v '^(PWD|SHLVL)')
_config_env+=(DATADIR)
_config_env+=(DATASET_TYPE)
_config_env+=(DGXSYSTEM)
mapfile -t _config_env < <(for v in "${_config_env[@]}"; do echo "--env=$v"; done)
docker run --rm --init --detach --gpus all\
    --net=host --uts=host --ipc=host --security-opt=seccomp=unconfined \
    --name="${_cont_name}" "${_cont_mounts[@]}" \
    "${CONT}" sleep infinity
docker exec -it "${_cont_name}" true
for _experiment_index in $(seq 1 "${NEXP}"); do
  (
    if [[ $CLEAR_CACHES == 1 ]]; then
      bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
      docker exec -it "${_cont_name}" python3 -c "
from mlperf_logging.mllog import constants
from mlperf_logger.utils import log_event
log_event(key=constants.CACHE_CLEAR, value=True)"
    fi
    echo "Beginning trial ${_experiment_index} of ${NEXP}"
    docker exec -it ${_config_env[@]} ${_cont_name} bash ./run_and_time.sh
  ) |& tee "${_logfile_base}_${_experiment_index}.log"
done
