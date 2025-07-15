#!/bin/bash
#FLUX: --job-name=dlrm.hugectr
#FLUX: --priority=16

set -euxo pipefail
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${CONT:?CONT not set}"
: "${DATADIR:?DATADIR not set}"
: "${NEXP:=10}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${CLEAR_CACHES:=1}"
: "${CHECK_COMPLIANCE:=1}"
: "${MLPERF_RULESET:=2.1.0}"
: "${MOUNTS:=${DATADIR}:/data}"
: "${LOGDIR:=./results}"
: "${DLRM_BIND:=}"
readonly _config_file="./config_${DGXSYSTEM}.sh"
readonly _logfile_base="${LOGDIR}/${DATESTAMP}"
readonly _cont_name=dlrm_hugectr
_cont_mounts=("--volume=${DATADIR}:/data" "--volume=${DATADIR}:/data_val" "--volume=${LOGDIR}:${LOGDIR}" "--volume=$(pwd):/workspace/dlrm")
mkdir -p "${LOGDIR}"
mapfile -t _config_env < <(env -i bash -c ". ${_config_file} && compgen -e" | grep -E -v '^(PWD|SHLVL)')
_config_env+=(DATADIR)
_config_env+=(DATASET_TYPE)
_config_env+=(DGXSYSTEM)
mapfile -t _config_env < <(for v in "${_config_env[@]}"; do echo "--env=$v"; done)
cleanup_docker() {
    docker container rm -f "${_cont_name}" || true
}
cleanup_docker
trap 'set -eux; cleanup_docker' EXIT
docker run --rm --init --detach --gpus all \
    --net=host --uts=host --ipc=host --security-opt=seccomp=unconfined -e MLPERF_SUBMISSION_ORG=GIGABYTE -e MLPERF_SUBMISSION_PLATFORM=G593-SD0  \
    --name="${_cont_name}" "${_cont_mounts[@]}" \
    "${CONT}" sleep infinity
sleep 30
docker exec -it "${_cont_name}" true
for _experiment_index in $(seq 1 "${NEXP}"); do
  (
    echo "Beginning trial ${_experiment_index} of ${NEXP}"
    if [[ $CLEAR_CACHES == 1 ]]; then
      bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
      docker exec -it "${_cont_name}" python3 -c "
import mlperf_logging.mllog as mllog
mllogger = mllog.get_mllogger()
mllogger.event(key=mllog.constants.CACHE_CLEAR, value=True)"
    fi
    docker exec -it ${_config_env[@]} ${_cont_name} bash ./run_and_time.sh
  ) |& tee "${_logfile_base}_${_experiment_index}.log"
    if [ "${CHECK_COMPLIANCE}" -eq 1 ]; then
      docker exec -it "${_config_env[@]}" "${_cont_name}"  \
           python3 -m mlperf_logging.compliance_checker --usage training \
           --ruleset "${MLPERF_RULESET}"                                 \
           --log_output "/results/compliance_${DATESTAMP}.out"           \
           "/results/${DATESTAMP}_${_experiment_index}.log" \
    || true
    fi
done
