#!/bin/bash
#FLUX: --job-name=cnn-extr_onep-mrnd
#FLUX: -c=10
#FLUX: --queue=plgrid-testing
#FLUX: -t=3600
#FLUX: --urgency=16

TSTAMP=$(date '+%m%d')
PROJECT=PROCESS_UC1
PROJECT_STORAGE=${PLG_GROUPS_STORAGE}/plggprocess/UC1
EXPERIMENT_ROOT=${PROJECT_STORAGE}/experiments/cnn-patch-extraction
CONF_DIR=${EXPERIMENT_ROOT}/conf
DATA_DIR=${EXPERIMENT_ROOT}/data/camelyon17/dev_data
SLURM_SUBMIT_DIR=${EXPERIMENT_ROOT}/scratch
RESULTS_DIR=${SLURM_SUBMIT_DIR}/${SLURM_JOB_NAME}
mkdir -p $RESULTS_DIR
cat > ${RESULTS_DIR}/README <<EOF
Directory names:
  <MMDD>.<slurm-job-id>.<slurm-task-id>.<subtask-id>
where
  <subtask-id> := random seed
EOF
run_id=$(printf '%03d' $SLURM_ARRAY_TASK_ID)
srun_id=${SLURM_ARRAY_JOB_ID}.${run_id}
myself=${SLURM_JOB_NAME}.${srun_id}
mods="
plgrid/tools/python/2.7.14
plgrid/libs/openslide/3.4.1
"
errs=0
for m in $mods; do
    module load $m || {
        echo 2>&1 "[ERROR] ${myself}: $m: can't load module"
        ((errs++))
    }
done
[[ $errs -gt 0 ]] && exit $errs
echo >&2 "[WARN] ${myself}: some modules won't be loaded -- only for patch extraction"
PYTHONPATH=${HOME}/projects/EnhanceR/${PROJECT}/code/${PROJECT}/lib/python2.7
PROCESS_UC1__HAS_SKIMAGE_VIEW=
PROCESS_UC1__HAS_TENSORFLOW=
export PYTHONPATH PROCESS_UC1__HAS_SKIMAGE_VIEW PROCESS_UC1__HAS_TENSORFLOW
declare -a patients
patients=($(ls --color=none ${DATA_DIR}/lesion_annotations/ | sed -nr 's/\.xml// p'))
[[ $patients ]] || {
    echo >&2 "[ERROR] ${myself}: no patient found in ${DATA_DIR}/lesion_annotations/"
    exit 1
}
patient=${patients[${SLURM_ARRAY_TASK_ID}]}
[[ $patient ]] || {
    echo >&2 "[WARN] ${myself}: no patient found at index '${SLURM_ARRAY_TASK_ID}'. Skipping..."
    exit 0
}
for s in $(seq 0 9); do
    stask_id=$(printf '%02d' $s)
    results_dir=${RESULTS_DIR}/${TSTAMP}.${srun_id}.${stask_id}
    cmnd="cnn --config-file=${CONF_DIR}/config.${SLURM_JOB_NAME}.ini --results-dir=${results_dir} --log-level=debug --patients=${patient} --seed=${s} extract"
    echo -e "[INFO] ${myself}: command line:\n    ${cmnd}"
    srun $cmnd || {
        echo 2>&1 "[ERROR] ${myself}: ${win_start}-${win_end}: subtask failed"
        ((errs++))
    }
done
exit $errs
